From: Florian Fainelli <f.fainelli@gmail.com>
Date: Mon, 21 Mar 2022 09:32:19 -0700
Subject: Question about the Broadcom Always On register panic handling
In-Reply-To: <6dac422b-d509-b863-0b31-98a07808ac0d@igalia.com>
References: <6dac422b-d509-b863-0b31-98a07808ac0d@igalia.com>
Message-ID: <781cafb0-8d06-8b56-907a-5175c2da196a@gmail.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 3/21/22 09:15, Guilherme G. Piccoli wrote:
> Hi Brian and Florian, I'm studying the panic notifiers and found one
> added by you in the commit 0b741b8234c ("soc: bcm: brcmstb: Add support
> for S2/S3/S5 suspend states (ARM)". Basically, the handler is very
> simple and the only thing it does is:
> 
> /* from drivers/soc/bcm/brcmstb/pm/aon_defs.h */
> #define AON_REG_PANIC		0x20
> #define BRCMSTB_PANIC_MAGIC	0x512E115E
> 
> /* from drivers/soc/bcm/brcmstb/pm/pm-arm.c*/
> brcmstb_pm_panic_notify() {
> 	writel_relaxed(BRCMSTB_PANIC_MAGIC, ctrl.aon_sram + AON_REG_PANIC);
> }
> 
> This write happens on panic time, but I couldn't find any
> information/documentation about the AON register and what effectively
> happens when this write is completed. Does the SoC reboots or anything
> like that?

The AON (standing for always-on) is a small domain in the SoC that can 
retain its state across various system wide sleep states and specific 
reset conditions. The AON DATA RAM is a small ram of a few words (< 1KB) 
which can store persistent information across such events.

The purpose of this write was initially to help with indicating to the 
boot loader that a panic occurred and so that it should try its best to 
preserve the DRAM contents holding that buffer for recovery by the Linux 
kernel as opposed to wiping out DRAM clean again. I cannot go into the 
mechanics of what happens publicly unfortunately.

> 
> Any information that helps me to document such panic event is very
> welcome, and in case you have AON documentation, it'd be also pretty great!

Why are you asking specifically about this if I may ask? If you are a 
legitimate Broadcom STB customer you can reach out to our support and I 
am sure the question will come back for me to answer.
-- 
Florian

