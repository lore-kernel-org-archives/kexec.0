Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from youngberry.canonical.com ([91.189.89.112])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lEvWI-0005ch-Ee
 for kexec@lists.infradead.org; Wed, 24 Feb 2021 14:52:07 +0000
Received: from mail-ej1-f70.google.com ([209.85.218.70])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <guilherme.piccoli@canonical.com>) id 1lEvWG-0002pW-6k
 for kexec@lists.infradead.org; Wed, 24 Feb 2021 14:52:04 +0000
Received: by mail-ej1-f70.google.com with SMTP id m4so915207ejc.14
 for <kexec@lists.infradead.org>; Wed, 24 Feb 2021 06:52:04 -0800 (PST)
MIME-Version: 1.0
References: <OF267FCB7E.EA06E022-ON00258685.0074D9AA-00258685.0074D9AE@notes.na.collabserv.com>
In-Reply-To: <OF267FCB7E.EA06E022-ON00258685.0074D9AA-00258685.0074D9AE@notes.na.collabserv.com>
From: "Guilherme G. Piccoli" <guilherme.piccoli@canonical.com>
Date: Wed, 24 Feb 2021 11:51:27 -0300
Message-ID: <CAHD1Q_z8zhpXFUybsPX6yOW2WPuYgpxsv-k90fwgqzyP1QqPVw@mail.gmail.com>
Subject: Re: Issues with kdump/kexec on an ARM dual-core ARM Cortex-A7.
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Bruce Mitchell <Bruce.Mitchell@ibm.com>
Cc: kexec mailing list <kexec@lists.infradead.org>

On Tue, Feb 23, 2021 at 6:18 PM Bruce Mitchell <Bruce.Mitchell@ibm.com> wrote:
>
>
> I am having troubles getting kdump/kexec functioning on an
> ARM dual-core ARM Cortex-A7 (a BMC by ASPEED AST2600) and QEMU.
> I do have kexec -l loading the new kernel, but after kexec -e
> the new kernel starts booting and the I get a watchdog BUG as shown here:
> [240.343350] kexec_core: Starting new kernel
> [241.639076] IRQ36: set affinity failed(-22).
> [241.657868] Bye!
> [ 0.000000] Booting Linux on physical CPU 0xf00
>

Just our of curiosity, what happens when you try "kexec -p" and induce
a kernel panic, to jump to kdump kernel? Does it work, or it's the
same?

Also, worth to try irqpoll maybe as a parameter of the second kernel,
to see if it can progress.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
