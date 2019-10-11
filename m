Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH v3 06/17] arm64, hibernate: add trans_pgd public functions
References: <20190821183204.23576-1-pasha.tatashin@soleen.com>
 <20190821183204.23576-7-pasha.tatashin@soleen.com>
 <bcc3f71f-97d2-dff4-c55a-4798c6e2bede@arm.com>
 <CA+CK2bCwRm_AQHzrJ8tdjp5k6Yj+32yRsvQsOoy7b44GTdd6wQ@mail.gmail.com>
From: James Morse <james.morse@arm.com>
Message-ID: <f1dbf5c6-7caf-daae-aec4-9a47a367c119@arm.com>
Date: Fri, 11 Oct 2019 19:16:50 +0100
MIME-Version: 1.0
In-Reply-To: <CA+CK2bCwRm_AQHzrJ8tdjp5k6Yj+32yRsvQsOoy7b44GTdd6wQ@mail.gmail.com>
Content-Language: en-GB
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
To: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Sasha Levin <sashal@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Vladimir Murzin <vladimir.murzin@arm.com>, Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Bhupesh Sharma <bhsharma@redhat.com>, kexec mailing list <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, James Morris <jmorris@namei.org>, linux-mm <linux-mm@kvack.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Matthias Brugger <matthias.bgg@gmail.com>, will@kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>

Hi Pavel,

On 06/09/2019 17:00, Pavel Tatashin wrote:
> On Fri, Sep 6, 2019 at 11:18 AM James Morse <james.morse@arm.com> wrote:
>> On 21/08/2019 19:31, Pavel Tatashin wrote:
>>> trans_pgd_create_copy() and trans_pgd_map_page() are going to be
>>> the basis for public interface of new subsystem that handles page
>>
>> Please don't call this a subsystem. 'sound' and 'mm' are subsystems, this is just some
>> shared code.

> Sounds good: just could not find a better term to call trans_pgd_*.

I don't like the trans_pgd_ name either, but I can't think of anything better, and its
only a name.


> I won't fix log commits.

Please avoid the word 'subsystem',


>>> diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
>>> index 750ecc7f2cbe..2e29d620b56c 100644
>>> --- a/arch/arm64/kernel/hibernate.c
>>> +++ b/arch/arm64/kernel/hibernate.c
>>> @@ -182,39 +182,15 @@ int arch_hibernation_header_restore(void *addr)
>>
>>> +int trans_pgd_map_page(pgd_t *trans_pgd, void *page,
>>> +                    unsigned long dst_addr,
>>> +                    pgprot_t pgprot)
>>
>> If this thing is going to be exposed, its name should reflect that its creating a set of
>> page tables, to map a single page.
>>
>> A function called 'map_page' with this prototype should 'obviously' map @page at @dst_addr
>> in @trans_pgd using the provided @pgprot... but it doesn't.
> 
> Answered below...
> 
>>
>> This is what 'create' was doing in the old name, if that wasn't obvious, its because
>> naming things is hard!
>> | trans_create_single_page_mapping()?
>>
>> (might be too verbose)
>>
>> I think this bites you in patch 8, where you 'generalise' this.

> The new naming makes more sense to me. The old code had function named:
> 
> create_safe_exec_page()
> 
> It was doing four things: 1. creating the actual page via provided
> allocator, 2. copying content from the provided page to new page, 3
> creating a new page table. 4 mapping it to a new page table at
> specified destination address

Yup, all implied in the work of creation.


> After, I generalize this the function the prototype looks like this:
> 
> int trans_pgd_map_page(struct trans_pgd_info *info, pgd_t *trans_pgd,
>                                          void *page, unsigned long
> dst_addr, pgprot_t pgprot)
> 
> The function only does the "4" from the old code: map the specified
> page at dst_addr.


> The trans_pgd is already created.

Which one is this?
The existing hibernate code has two PGD. One for the copy of the linear-map, one for this
safe page that contains the code doing the copying.


> Of course, and
> mapping function will have to allocate missing tables in the page
> tables when necessary.

I think you are over generalising this, to support a case that doesn't exist.

Hibernate needs a copy of the linear map to relocate memory, without stepping in
page-table, and an executable page it can do that from.

To get kexec to relocate the kernel with the MMU on... you need the same.

When do you need to add an arbitrary page to either of these sets of tables? Its either a
copy of the linear-map, or the single executable page.

When would does 'trans_pgd_map_page()' get used outside those two?

(looking in your later series, I see you are using it to try and idmap stuff into the low
memory. We can't do stuff like this because there may not be any memory in range of the
page table helpers. More details in that patch)


Thanks,

James

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
