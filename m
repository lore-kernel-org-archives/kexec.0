From: Guilherme G. Piccoli <gpiccoli@igalia.com>
Date: Mon, 21 Mar 2022 13:15:41 -0300
Subject: Question about the Broadcom Always On register panic handling
Message-ID: <6dac422b-d509-b863-0b31-98a07808ac0d@igalia.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Hi Brian and Florian, I'm studying the panic notifiers and found one
added by you in the commit 0b741b8234c ("soc: bcm: brcmstb: Add support
for S2/S3/S5 suspend states (ARM)". Basically, the handler is very
simple and the only thing it does is:

/* from drivers/soc/bcm/brcmstb/pm/aon_defs.h */
#define AON_REG_PANIC		0x20
#define BRCMSTB_PANIC_MAGIC	0x512E115E

/* from drivers/soc/bcm/brcmstb/pm/pm-arm.c*/
brcmstb_pm_panic_notify() {
	writel_relaxed(BRCMSTB_PANIC_MAGIC, ctrl.aon_sram + AON_REG_PANIC);
}

This write happens on panic time, but I couldn't find any
information/documentation about the AON register and what effectively
happens when this write is completed. Does the SoC reboots or anything
like that?

Any information that helps me to document such panic event is very
welcome, and in case you have AON documentation, it'd be also pretty great!

Thanks in advance,


Guilherme

