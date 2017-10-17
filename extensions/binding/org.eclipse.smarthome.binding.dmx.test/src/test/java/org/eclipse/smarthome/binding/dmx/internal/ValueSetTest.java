/**
 * Copyright (c) 2014-2017 by the respective copyright holders.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 */
package org.eclipse.smarthome.binding.dmx.internal;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

import org.eclipse.smarthome.binding.dmx.internal.ValueSet;
import org.junit.Test;

/**
 * Tests cases ValueSet
 *
 * @author Jan N. Klug - Initial contribution
 */
public class ValueSetTest {

    @Test
    public void fadeAndHoldTime() {
        ValueSet valueSet = new ValueSet(100, 200);

        assertThat(valueSet.getFadeTime(), is(100));
        assertThat(valueSet.getHoldTime(), is(200));
    }

    @Test
    public void valueAndRepetition() {
        ValueSet valueSet = new ValueSet(0, 0);
        valueSet.addValue(100);
        valueSet.addValue(200);

        // stored values
        assertThat(valueSet.getValue(0), is(100));
        assertThat(valueSet.getValue(1), is(200));

        // repetitions
        assertThat(valueSet.getValue(2), is(100));
        assertThat(valueSet.getValue(5), is(200));
    }

    public void fromString() {
        ValueSet valueSet = ValueSet.fromString("1000:100,200:-1");

        // times
        assertThat(valueSet.getFadeTime(), is(1000));
        assertThat(valueSet.getHoldTime(), is(-1));

        // values
        assertThat(valueSet.getValue(0), is(100));
        assertThat(valueSet.getValue(1), is(200));
    }

}
