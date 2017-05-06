Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-it0-x22c.google.com ([2607:f8b0:4001:c0b::22c])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1d6uSJ-0001iy-Qs
 for kexec@lists.infradead.org; Sat, 06 May 2017 07:48:46 +0000
Received: by mail-it0-x22c.google.com with SMTP id c15so42381705ith.0
 for <kexec@lists.infradead.org>; Sat, 06 May 2017 00:48:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170505171155.4fm22ks6m5j7lpjm@pd.tnic>
References: <20170418211612.10190.82788.stgit@tlendack-t1.amdoffice.net>
 <20170418211831.10190.80158.stgit@tlendack-t1.amdoffice.net>
 <20170505171155.4fm22ks6m5j7lpjm@pd.tnic>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Sat, 6 May 2017 08:48:22 +0100
Message-ID: <CAKv+Gu-h+1UWPCUwvJT2AD=JtPqYQRRrrUCFjWNiAOCKfHh7rg@mail.gmail.com>
Subject: Re: [PATCH v5 13/32] x86/boot/e820: Add support to determine the E820
 type of an address
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
Cc: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, Brijesh Singh <brijesh.singh@amd.com>, Toshimitsu Kani <toshi.kani@hpe.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Matt Fleming <matt@codeblueprint.co.uk>, "x86@kernel.org" <x86@kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Alexander Potapenko <glider@google.com>, "H. Peter Anvin" <hpa@zytor.com>, Larry Woodman <lwoodman@redhat.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, KVM devel mailing list <kvm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Joerg Roedel <joro@8bytes.org>, linux-doc@vger.kernel.org, kasan-dev <kasan-dev@googlegroups.com>, Ingo Molnar <mingo@redhat.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Dave Young <dyoung@redhat.com>, Tom Lendacky <thomas.lendacky@amd.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 5 May 2017 at 18:11, Borislav Petkov <bp@alien8.de> wrote:
> On Tue, Apr 18, 2017 at 04:18:31PM -0500, Tom Lendacky wrote:
>> Add a function that will return the E820 type associated with an address
>> range.
>
> ...
>
>> @@ -110,9 +111,28 @@ bool __init e820__mapped_all(u64 start, u64 end, enum e820_type type)
>>                * coverage of the desired range exists:
>>                */
>>               if (start >= end)
>> -                     return 1;
>> +                     return entry;
>>       }
>> -     return 0;
>> +
>> +     return NULL;
>> +}
>> +
>> +/*
>> + * This function checks if the entire range <start,end> is mapped with type.
>> + */
>> +bool __init e820__mapped_all(u64 start, u64 end, enum e820_type type)
>> +{
>> +     return __e820__mapped_all(start, end, type) ? 1 : 0;
>
>         return !!__e820__mapped_all(start, end, type);
>

Even the !! double negation is redundant, given that the function returns bool.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
