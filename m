Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VgEwJ-0007Yo-6z
 for kexec@lists.infradead.org; Tue, 12 Nov 2013 14:27:36 +0000
Date: Tue, 12 Nov 2013 09:26:52 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [patch 1/3 v2] Add function get_bootparam
Message-ID: <20131112142652.GA24980@redhat.com>
References: <20131105082947.500512312@dhcp-16-126.nay.redhat.com>
 <20131105083428.411624560@dhcp-16-126.nay.redhat.com>
 <1384219658.1847.84.camel@misato.fc.hp.com>
 <52819E71.70201@zytor.com> <20131112035344.GA28116@gmail.com>
 <aa0ccca4-b27b-41b6-8adb-3c969eb29bf7@email.android.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aa0ccca4-b27b-41b6-8adb-3c969eb29bf7@email.android.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-efi@vger.kernel.org, Toshi Kani <toshi.kani@hp.com>, Greg KH <greg@kroah.com>, x86@kernel.org, kexec@lists.infradead.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, bp@alien8.de, ebiederm@xmission.com, "H. Peter Anvin" <hpa@zytor.com>, dyoung@redhat.com, Ingo Molnar <mingo@kernel.org>

On Tue, Nov 12, 2013 at 04:58:50PM +1300, Matthew Garrett wrote:
> Well, there's one alternative - don't export this at all and only support UEFI kernels that have an in-kernel loader, then just pass the data internally. 

Hi Matthew,

I am still writing that in-kernel support for kexec/kdump. I guess in
next 2 weeks I might be able to post a basic RFC version. (no EFI support
in this version though).

Having said that, I think that it is good to export these values to
user space and make existing code work with UEFI. New code (if it gets
in at all) will slowly mature over a period of time and transition to it
will be slow. I think initially it will be used only if secureboot is
enabled. And in the mean time we need a good solution for kexec/kdump
with UEFI. 

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
