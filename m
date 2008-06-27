Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from py-out-1112.google.com ([64.233.166.181])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KCIjj-0004b7-5z
	for kexec@lists.infradead.org; Fri, 27 Jun 2008 18:31:55 +0000
Received: by py-out-1112.google.com with SMTP id a73so462943pye.2
	for <kexec@lists.infradead.org>; Fri, 27 Jun 2008 11:31:54 -0700 (PDT)
Message-ID: <86802c440806271131q2fe2c2cubea2c810b99b9302@mail.gmail.com>
Date: Fri, 27 Jun 2008 11:31:53 -0700
From: "Yinghai Lu" <yhlu.kernel@gmail.com>
Subject: Re: [PATCH 2/2] Use FIRMWARE_MEMMAP on x86/E820
In-Reply-To: <20080627131415.4d482af2@halley.suse.de>
MIME-Version: 1.0
Content-Disposition: inline
References: <1214511542-28458-1-git-send-email-bwalle@suse.de>
	<1214511542-28458-3-git-send-email-bwalle@suse.de>
	<86802c440806261354y673a5521ie615feafae3b2bd8@mail.gmail.com>
	<20080627131415.4d482af2@halley.suse.de>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Bernhard Walle <bwalle@suse.de>
Cc: x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, vgoyal@redhat.com, gregkh@suse.de

On Fri, Jun 27, 2008 at 4:14 AM, Bernhard Walle <bwalle@suse.de> wrote:
> * Yinghai Lu [2008-06-26 13:54]:
>>
>> looks good...
>>
>> will produce one patch update early_reserve_e820_mpc_new or
>> early_reserve_e820 to update e820_saved too. that contained updated
>> mptable for second kernel without acpi support.
>
> You or me? I don't understand ...

after your patch are merged into tip, I will produce one patch to fix
early_reserve_e820...

YH

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
