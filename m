Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VK1Qa-0005yU-JP
 for kexec@lists.infradead.org; Thu, 12 Sep 2013 07:35:01 +0000
Date: Thu, 12 Sep 2013 15:34:15 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 15/16] bootparam: Pass acpi_rsdp pointer in bootparam
Message-ID: <20130912064930.GA5288@dhcp-16-126.nay.redhat.com>
References: <1378849471-10521-1-git-send-email-vgoyal@redhat.com>
 <1378849471-10521-16-git-send-email-vgoyal@redhat.com>
 <522FA2A8.8080703@zytor.com> <20130911114419.GB31551@x1.alien8.de>
 <20130911134534.GB15364@redhat.com>
 <20130911143216.GA933@x1.alien8.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130911143216.GA933@x1.alien8.de>
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
Cc: matthew.garrett@nebula.com, d.kasatkin@samsung.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, ebiederm@xmission.com, "H. Peter Anvin" <hpa@zytor.com>, akpm@linux-foundation.org, zohar@linux.vnet.ibm.com, Vivek Goyal <vgoyal@redhat.com>

On 09/11/13 at 04:32pm, Borislav Petkov wrote:
> On Wed, Sep 11, 2013 at 09:45:34AM -0400, Vivek Goyal wrote:
> > I am looking forward to that new version. CCing Dave Young. He is also
> > looking into it and going through history of patches.
> 
> Ok, I'll CC you guys on the submission - I'd need any and all feedback I
> can get on that topic.

I'm playing with skipping SetVirtualAddressMap in kexec kernel, for same kernel
the test result is ok for me both for kexec and kdump. Takao Indoh sent a patch
with this approatch, but his V2 switched to use physical mapping.
During my test, additional data of config table elems need to be saved besides of
fw_vendor, runtime and tables or dereference taglep->guid will panic.

Also kexec userspace need to fill efi_info in bootparams and pass the previous
saved efi data to 2nd kernel.

I'm worrying just skiping enter virt mode have risk though it's an easy solution.
Your 1:1 mapping approatch looks better. I look forward to test your new patchset.
Are you also working on kexec userspace part? Already have a patch?

> 
> Thanks.
> 
> -- 
> Regards/Gruss,
> Boris.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
