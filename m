Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:120:8448::d00d])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VK85g-00027w-Jf
 for kexec@lists.infradead.org; Thu, 12 Sep 2013 14:41:53 +0000
Date: Thu, 12 Sep 2013 16:42:07 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 15/16] bootparam: Pass acpi_rsdp pointer in bootparam
Message-ID: <20130912144207.GA10495@x1.alien8.de>
References: <1378849471-10521-1-git-send-email-vgoyal@redhat.com>
 <1378849471-10521-16-git-send-email-vgoyal@redhat.com>
 <522FA2A8.8080703@zytor.com> <20130911114419.GB31551@x1.alien8.de>
 <20130911134534.GB15364@redhat.com>
 <20130911143216.GA933@x1.alien8.de>
 <20130912064930.GA5288@dhcp-16-126.nay.redhat.com>
 <20130912125350.GB9280@x1.alien8.de>
 <1378996498.945.4.camel@x230.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1378996498.945.4.camel@x230.lan>
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
To: Matthew Garrett <matthew.garrett@nebula.com>
Cc: "zohar@linux.vnet.ibm.com" <zohar@linux.vnet.ibm.com>, "d.kasatkin@samsung.com" <d.kasatkin@samsung.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, "ebiederm@xmission.com" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

On Thu, Sep 12, 2013 at 02:34:58PM +0000, Matthew Garrett wrote:
> The second kernel still needs to be passed a pointer to the EFI tables
> and memory map.

Date: Thu, 12 Sep 2013 14:53:50 +0200
From: Borislav Petkov <bp@alien8.de
Message-ID: <20130912125350.GB9280@x1.alien8.de>

On Thu, Sep 12, 2013 at 03:34:15PM +0800, Dave Young wrote:
> Also kexec userspace need to fill efi_info in bootparams and pass the
> previous saved efi data to 2nd kernel.

Hmm, yes, we need to tell the kexec kernel the EFI regions.

-- 
Regards/Gruss,
Boris.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
