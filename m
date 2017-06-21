Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-cys01nam02on061e.outbound.protection.outlook.com
 ([2a01:111:f400:fe45::61e]
 helo=NAM02-CY1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dNkYY-0000rD-Of
 for kexec@lists.infradead.org; Wed, 21 Jun 2017 18:40:48 +0000
Subject: Re: [PATCH v6 26/34] iommu/amd: Allow the AMD IOMMU to work with
 memory encryption
References: <20170607191309.28645.15241.stgit@tlendack-t1.amdoffice.net>
 <20170607191745.28645.81756.stgit@tlendack-t1.amdoffice.net>
 <20170614174208.p2yr5exs4b6pjxhf@pd.tnic>
 <0611d01a-19f8-d6ae-2682-932789855518@amd.com>
 <20170615094111.wga334kg2bhxqib3@pd.tnic> <20170621153721.GP30388@8bytes.org>
 <20170621165921.tv2jfhf5dz7hsjsy@pd.tnic>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <26d48eb1-4d33-4abf-f169-3ce86aef22fe@amd.com>
Date: Wed, 21 Jun 2017 13:40:14 -0500
MIME-Version: 1.0
In-Reply-To: <20170621165921.tv2jfhf5dz7hsjsy@pd.tnic>
Content-Language: en-US
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Borislav Petkov <bp@alien8.de>, Joerg Roedel <joro@8bytes.org>
Cc: linux-efi@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>, Toshimitsu Kani <toshi.kani@hpe.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Matt Fleming <matt@codeblueprint.co.uk>, x86@kernel.org, linux-mm@kvack.org, Alexander Potapenko <glider@google.com>, "H. Peter Anvin" <hpa@zytor.com>, Larry Woodman <lwoodman@redhat.com>, linux-arch@vger.kernel.org, kvm@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, kasan-dev@googlegroups.com, Ingo Molnar <mingo@redhat.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Dave Young <dyoung@redhat.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 6/21/2017 11:59 AM, Borislav Petkov wrote:
> On Wed, Jun 21, 2017 at 05:37:22PM +0200, Joerg Roedel wrote:
>>> Do you mean this is like the last exception case in that document above:
>>>
>>> "
>>>    - Pointers to data structures in coherent memory which might be modified
>>>      by I/O devices can, sometimes, legitimately be volatile.  A ring buffer
>>>      used by a network adapter, where that adapter changes pointers to
>>>      indicate which descriptors have been processed, is an example of this
>>>      type of situation."
>>>
>>> ?
>>
>> So currently (without this patch) the build_completion_wait function
>> does not take a volatile parameter, only wait_on_sem() does.
>>
>> Wait_on_sem() needs it because its purpose is to poll a memory location
>> which is changed by the iommu-hardware when its done with command
>> processing.
> 
> Right, the reason above - memory modifiable by an IO device. You could
> add a comment there explaining the need for the volatile.
> 
>> But the 'volatile' in build_completion_wait() looks unnecessary, because
>> the function does not poll the memory location. It only uses the
>> pointer, converts it to a physical address and writes it to the command
>> to be queued.
> 
> Ok.

Ok, so the (now) current version of the patch that doesn't change the
function signature is the right way to go.

Thanks,
Tom

> 
> Thanks.
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
