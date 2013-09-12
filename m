Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:120:8448::d00d])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VK7pm-0001bL-I0
 for kexec@lists.infradead.org; Thu, 12 Sep 2013 14:25:29 +0000
Date: Thu, 12 Sep 2013 16:25:37 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 15/16] bootparam: Pass acpi_rsdp pointer in bootparam
Message-ID: <20130912142537.GA10143@x1.alien8.de>
References: <1378849471-10521-1-git-send-email-vgoyal@redhat.com>
 <1378849471-10521-16-git-send-email-vgoyal@redhat.com>
 <522FA2A8.8080703@zytor.com> <20130911114419.GB31551@x1.alien8.de>
 <20130911134534.GB15364@redhat.com>
 <20130911143216.GA933@x1.alien8.de>
 <20130912064930.GA5288@dhcp-16-126.nay.redhat.com>
 <20130912125350.GB9280@x1.alien8.de>
 <20130912131930.GC28500@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130912131930.GC28500@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: matthew.garrett@nebula.com, zohar@linux.vnet.ibm.com, d.kasatkin@samsung.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, ebiederm@xmission.com, "H. Peter Anvin" <hpa@zytor.com>, akpm@linux-foundation.org, Dave Young <dyoung@redhat.com>

On Thu, Sep 12, 2013 at 09:19:30AM -0400, Vivek Goyal wrote:
> I did not understand this argument that we need to use high virtual
> addresses because windows is using it and now we end up creating
> fixed EFI addresses and that becomes an ABI. If EFI implementations

The only thing that becomes sort-of ABI is that we start the mappings at
-4G virtual.

> are dependent on high addresses being passed, shouldn't it be those
> implementations which need to be fixed instead of kernel fixing EFI

Right, this is the biggest issue with firmware - vendors like to declare
those as End-of-Life platforms and for them there are no fixes. This is
the reason why we don't do the 1:1 mappings.

> addresses in higher region.

The thing is, reportedly some Apple UEFI implementations cannot stomach
1:1 SetVirtualAddressMap mappings. Also, the high addresses mappings is
the only thing that vendors test on windoze so in that field we want
to do what windoze does as this is the only thing that gets reliable
testing.

But I get the feeling we're feeling up stuff in the dark as firmware is
closed crap which we cannot look at.

HTH.

-- 
Regards/Gruss,
Boris.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
