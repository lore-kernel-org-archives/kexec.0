Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VK6oX-0007s3-Bm
 for kexec@lists.infradead.org; Thu, 12 Sep 2013 13:20:07 +0000
Date: Thu, 12 Sep 2013 09:19:30 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 15/16] bootparam: Pass acpi_rsdp pointer in bootparam
Message-ID: <20130912131930.GC28500@redhat.com>
References: <1378849471-10521-1-git-send-email-vgoyal@redhat.com>
 <1378849471-10521-16-git-send-email-vgoyal@redhat.com>
 <522FA2A8.8080703@zytor.com> <20130911114419.GB31551@x1.alien8.de>
 <20130911134534.GB15364@redhat.com>
 <20130911143216.GA933@x1.alien8.de>
 <20130912064930.GA5288@dhcp-16-126.nay.redhat.com>
 <20130912125350.GB9280@x1.alien8.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130912125350.GB9280@x1.alien8.de>
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
To: Borislav Petkov <bp@alien8.de>
Cc: matthew.garrett@nebula.com, zohar@linux.vnet.ibm.com, d.kasatkin@samsung.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, ebiederm@xmission.com, "H. Peter Anvin" <hpa@zytor.com>, akpm@linux-foundation.org, Dave Young <dyoung@redhat.com>

On Thu, Sep 12, 2013 at 02:53:50PM +0200, Borislav Petkov wrote:

[..]
> > Are you also working on kexec userspace part? Already have a patch?
> 
> Why userspace part -

I think Dave is referring to passing efi related tables to second kernel
in bootparams.

> I'm thinking the kexec'ed kernel would simply add
> the mappings made by SetVirtualAddressMap without calling it. And it
> will know which mappings go to which virtual addresses because we start
> at the -4G virtual address and go downwards and the mappings will have
> the same addresses per UEFI implementation.

Ok, so virtual addresses for EFI mappings are fixed and that's why first
kernel need not pass it to second kernel. Second kernel will again map
EFI regions using those fixed virtual addresses and *not* call
SetVirtualAddressMap() and hence it should be able to make run time calls.
Sounds good.

I was going through previous conversations in your postings. I kind of
liked James Bottomley's suggestion of calling SetVirtualAdddressMap()
with 1:1 mapping.

I did not understand this argument that we need to use high virtual
addresses because windows is using it and now we end up creating
fixed EFI addresses and that becomes an ABI. If EFI implementations
are dependent on high addresses being passed, shouldn't it be those
implementations which need to be fixed instead of kernel fixing EFI
addresses in higher region.

Anyway, I am not an EFI expert. I just need a working solution. How to
do it, I will leave it to experts.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
