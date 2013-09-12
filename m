Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-by2ln0186.outbound.protection.outlook.com
 ([2a01:111:f400:7c0c::186] helo=na01-by2-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VK7za-0001u3-De
 for kexec@lists.infradead.org; Thu, 12 Sep 2013 14:35:38 +0000
From: Matthew Garrett <matthew.garrett@nebula.com>
Subject: Re: [PATCH 15/16] bootparam: Pass acpi_rsdp pointer in bootparam
Date: Thu, 12 Sep 2013 14:34:58 +0000
Message-ID: <1378996498.945.4.camel@x230.lan>
References: <1378849471-10521-1-git-send-email-vgoyal@redhat.com>
 <1378849471-10521-16-git-send-email-vgoyal@redhat.com>
 <522FA2A8.8080703@zytor.com> <20130911114419.GB31551@x1.alien8.de>
 <20130911134534.GB15364@redhat.com> <20130911143216.GA933@x1.alien8.de>
 <20130912064930.GA5288@dhcp-16-126.nay.redhat.com>
 <20130912125350.GB9280@x1.alien8.de>
In-Reply-To: <20130912125350.GB9280@x1.alien8.de>
Content-Language: en-US
Content-ID: <3A76A262E8F59E4B9A638565CAA71CF3@namprd05.prod.outlook.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Borislav Petkov <bp@alien8.de>
Cc: "zohar@linux.vnet.ibm.com" <zohar@linux.vnet.ibm.com>, "d.kasatkin@samsung.com" <d.kasatkin@samsung.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, "ebiederm@xmission.com" <ebiederm@xmission.com>, "H.
 Peter Anvin" <hpa@zytor.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

On Thu, 2013-09-12 at 14:53 +0200, Borislav Petkov wrote:

> Why userspace part - I'm thinking the kexec'ed kernel would simply add
> the mappings made by SetVirtualAddressMap without calling it. And it
> will know which mappings go to which virtual addresses because we start
> at the -4G virtual address and go downwards and the mappings will have
> the same addresses per UEFI implementation.

The second kernel still needs to be passed a pointer to the EFI tables
and memory map.

-- 
Matthew Garrett <matthew.garrett@nebula.com>
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
