Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from usindpps03.hds.com ([207.126.252.16])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RzV2l-0000Rm-1g
 for kexec@lists.infradead.org; Mon, 20 Feb 2012 15:20:47 +0000
From: Seiji Aguchi <seiji.aguchi@hds.com>
Date: Mon, 20 Feb 2012 10:20:34 -0500
Subject: RE: [PATCH] x86, kdump, ioapic: Fix kdump race with migrating irq
Message-ID: <5C4C569E8A4B9B42A84A977CF070A35B2DAC909D43@USINDEVS01.corp.hds.com>
References: <1328045114-4489-1-git-send-email-dzickus@redhat.com>
In-Reply-To: <1328045114-4489-1-git-send-email-dzickus@redhat.com>
Content-Language: en-US
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Don Zickus <dzickus@redhat.com>, "x86@kernel.org" <x86@kernel.org>
Cc: kexec-list <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, "vgoyal@redhat.com" <vgoyal@redhat.com>, "ebiederm@xmission.com" <ebiederm@xmission.com>

> -void disable_IO_APIC(void)
> +void disable_IO_APIC(int force)
> {
> 	/*
>+	 * Use force to bust the io_apic spinlock
>+	 *
>+	 * There is a case where kdump can race with irq
>+	 * migration such that kdump will inject an NMI
>+	 * while another cpu holds the ioapic_lock to
>+	 * migrate the irq.  This would cause a deadlock.
>+	 *
>+	 * Because kdump stops all the cpus, we can safely
>+	 * bust the spinlock as we are just clearing the
>+	 * io apic anyway.
>+	 */
>+	if (force && spin_is_locked(&ioapic_lock))
>+		/* only one cpu should be running now */
>+		spin_lock_init(&ioapic_lock);
>+
>+	/*

Hmm...

This patch solves the kdump race, but it may make us confuse when we analyze vmcore,
Because it clears value of ioapic_lock without notice.

It kernel panic is related to IO_APIC, they will check value of ioapic_lock.

So, it is better if we can restore the value of ioapic_lock after calling disable_IO_APIC(),  
IOW, my idea is following.
 - Backup value of ioapic_lock
 - Bust ioapic_lock
 -  Call disable_IO_APIC()
 - Restore value of ioapic_lock

But, as you are discussing with Eric, we don't need to worry about this if we can completely remove disable_IO_APIC().

Seiji



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
