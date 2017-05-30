Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-dm3nam03on0076.outbound.protection.outlook.com
 ([104.47.41.76] helo=NAM03-DM3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dFjDI-0001QC-6k
 for kexec@lists.infradead.org; Tue, 30 May 2017 15:37:41 +0000
Subject: Re: [PATCH v5 32/32] x86/mm: Add support to make use of Secure Memory
 Encryption
References: <20170418211612.10190.82788.stgit@tlendack-t1.amdoffice.net>
 <20170418212223.10190.85121.stgit@tlendack-t1.amdoffice.net>
 <20170519112703.voajtn4t7uy6nwa3@pd.tnic>
 <7c522f65-c5c8-9362-e1eb-d0765e3ea6c9@amd.com>
 <20170530145459.tyuy6veqxnrqkhgw@pd.tnic>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <115ca39d-6ae7-f603-a415-ead7c4e8193d@amd.com>
Date: Tue, 30 May 2017 10:37:03 -0500
MIME-Version: 1.0
In-Reply-To: <20170530145459.tyuy6veqxnrqkhgw@pd.tnic>
Content-Language: en-US
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
To: Borislav Petkov <bp@alien8.de>
Cc: linux-efi@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>, Toshimitsu Kani <toshi.kani@hpe.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Matt Fleming <matt@codeblueprint.co.uk>, x86@kernel.org, linux-mm@kvack.org, Alexander Potapenko <glider@google.com>, "H. Peter
 Anvin" <hpa@zytor.com>, Larry Woodman <lwoodman@redhat.com>, linux-arch@vger.kernel.org, kvm@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Joerg Roedel <joro@8bytes.org>, linux-doc@vger.kernel.org, kasan-dev@googlegroups.com, Ingo Molnar <mingo@redhat.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Dave Young <dyoung@redhat.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, "Michael S.
 Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 5/30/2017 9:55 AM, Borislav Petkov wrote:
> On Tue, May 30, 2017 at 09:38:36AM -0500, Tom Lendacky wrote:
>> In this case we're running identity mapped and the "on" constant ends up
>> as kernel address (0xffffffff81...) which results in a segfault.
> 
> Would
> 
> 	static const char *__on_str = "on";
> 
> 	...
> 
> 	if (!strncmp(buffer, __pa_nodebug(__on_str), 2))
> 		...
> 
> work?
> 
> __phys_addr_nodebug() seems to pay attention to phys_base and
> PAGE_OFFSET and so on...

Except that phys_base hasn't been adjusted yet so that doesn't work
either.

> 
> I'd like to avoid that rip-relative address finding in inline asm which
> looks fragile to me.

I can define the command line option and the "on" and "off" values as
character buffers in the function and initialize them on a per character
basis (using a static string causes the same issues as referencing a
string constant), i.e.:

char cmdline_arg[] = {'m', 'e', 'm', '_', 'e', 'n', 'c', 'r', 'y', 'p', 't', '\0'};
char cmdline_off[] = {'o', 'f', 'f', '\0'};
char cmdline_on[] = {'o', 'n', '\0'};

It doesn't look the greatest, but it works and removes the need for the
rip-relative addressing.

Thanks,
Tom

> 
> Thanks.
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
