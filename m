Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([198.137.202.10] helo=mail.zytor.com)
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1Ok2gq-0001IE-Bq
	for kexec@lists.infradead.org; Fri, 13 Aug 2010 22:25:29 +0000
Message-ID: <4C65C630.4070008@zytor.com>
Date: Fri, 13 Aug 2010 15:24:48 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH][EFI] Run EFI in physical mode
References: <F0CB3B1C601247indou.takao@jp.fujitsu.com>
In-Reply-To: <F0CB3B1C601247indou.takao@jp.fujitsu.com>
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
To: Takao Indoh <indou.takao@jp.fujitsu.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, nhorman@tuxdriver.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, ebiederm@xmission.com, tglx@linutronix.de, vgoyal@redhat.com

On 08/13/2010 12:18 PM, Takao Indoh wrote:
> 
> Basically EFI is in physical mode at first and it's switched to virtual
> mode after calling SetVirtualAddressMap. By applying this patch, you can
> run EFI always in physical mode. And you can also specify "virtefi" as
> kernel boot parameter to run EFI in virtual mode as before. Note that
> this patch supports only x86_64.
> 

Any hope to get a followon patch for i386 as well?  That would make it
largely a no-brainer.

Tony, does this affect ia64 in any way?

	-hpa

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
