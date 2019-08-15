Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH v1 0/8] arm64: MMU enabled kexec relocation
References: <20190801152439.11363-1-pasha.tatashin@soleen.com>
 <CA+CK2bADiBMEx9cJuXT5fQkBYFZAtxUtc7ZzjrNfEjijPZkPtw@mail.gmail.com>
From: James Morse <james.morse@arm.com>
Message-ID: <ba8a2519-ed95-2518-d0e8-66e8e0c14ff5@arm.com>
Date: Thu, 15 Aug 2019 19:11:10 +0100
MIME-Version: 1.0
In-Reply-To: <CA+CK2bADiBMEx9cJuXT5fQkBYFZAtxUtc7ZzjrNfEjijPZkPtw@mail.gmail.com>
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
Cc: Sasha Levin <sashal@kernel.org>, Vladimir Murzin <vladimir.murzin@arm.com>, Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Bhupesh Sharma <bhsharma@redhat.com>, kexec mailing list <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, James Morris <jmorris@namei.org>, linux-mm <linux-mm@kvack.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Matthias Brugger <matthias.bgg@gmail.com>, will@kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>

Hi Pavel,

On 08/08/2019 19:44, Pavel Tatashin wrote:
> Just a friendly reminder, please send your comments on this series.

(Please don't top-post)


> It's been a week since I sent out these patches, and no feedback yet.

A week is not a lot of time, people are busy, go to conferences, some even dare to take
holiday!


> Also, I'd appreciate if anyone could test this series on vhe hardware
> with vhe kernel, it does not look like QEMU can emulate it yet

This locks up during resume from hibernate on my AMD Seattle, a regular v8.0 machine.


Please try and build the series to reduce review time. What you have here is an all-new
page-table generation API, which you switch hibernate and kexec too. This is effectively a
new implementation of hibernate and kexec. There are three things here that need review.

You have a regression in your all-new implementation of hibernate. It took six months (and
lots of review) to get the existing code right, please don't rip it out if there is
nothing wrong with it.


Instead, please just move the hibernate copy_page_tables() code, and then wire kexec up.
You shouldn't need to change anything in the copy_page_tables() code as the linear map is
the same in both cases.


It looks like you are creating the page tables just after the kexec:segments have been
loaded. This will go horribly wrong if anything changes between then and kexec time. (e.g.
memory you've got mapped gets hot-removed).
This needs to be done as late as possible, so we don't waste memory, and the world can't
change around us. Reboot notifiers run before kexec, can't we do the memory-allocation there?


> On Thu, Aug 1, 2019 at 11:24 AM Pavel Tatashin
> <pasha.tatashin@soleen.com> wrote:
>>
>> Enable MMU during kexec relocation in order to improve reboot performance.
>>
>> If kexec functionality is used for a fast system update, with a minimal
>> downtime, the relocation of kernel + initramfs takes a significant portion
>> of reboot.
>>
>> The reason for slow relocation is because it is done without MMU, and thus
>> not benefiting from D-Cache.
>>
>> Performance data
>> ----------------
>> For this experiment, the size of kernel plus initramfs is small, only 25M.
>> If initramfs was larger, than the improvements would be greater, as time
>> spent in relocation is proportional to the size of relocation.
>>
>> Previously:
>> kernel shutdown 0.022131328s
>> relocation      0.440510736s
>> kernel startup  0.294706768s
>>
>> Relocation was taking: 58.2% of reboot time
>>
>> Now:
>> kernel shutdown 0.032066576s
>> relocation      0.022158152s
>> kernel startup  0.296055880s
>>
>> Now: Relocation takes 6.3% of reboot time
>>
>> Total reboot is x2.16 times faster.

When I first saw these numbers they were ~'0.29s', which I wrongly assumed was 29 seconds.
Savings in milliseconds, for _reboot_ is a hard sell. I'm hoping that on the machines that
take minutes to kexec we'll get numbers that make this change more convincing.


Thanks,

James

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
