Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [Bug Report] kdump crashes after latest EFI memblock changes on
 arm64 machines with large number of CPUs
References: <CACi5LpOyy0YkhEzWWqt8hAQfKku2Vzp5+da_dGS23JMyHReNew@mail.gmail.com>
 <CAKv+Gu_1PNiGbgRqd3_0k6CGzh-2P+iAmqk=oSSek69kBCnb8Q@mail.gmail.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <f5c4c03a-e88f-ea42-b791-e50808e8247b@arm.com>
Date: Mon, 5 Nov 2018 11:31:37 +0000
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu_1PNiGbgRqd3_0k6CGzh-2P+iAmqk=oSSek69kBCnb8Q@mail.gmail.com>
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
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Bhupesh Sharma <bhsharma@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-efi <linux-efi@vger.kernel.org>, kexec mailing list <kexec@lists.infradead.org>, Will Deacon <will.deacon@arm.com>, Bhupesh SHARMA <bhupesh.linux@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On 05/11/18 11:11, Ard Biesheuvel wrote:
> (+ Marc)
> 
> On 1 November 2018 at 22:14, Bhupesh Sharma <bhsharma@redhat.com> wrote:
>> Hi,
>>
>> With the latest EFI changes for memblock reservation across kdump
>> kernel from Ard (Commit 71e0940d52e107748b270213a01d3b1546657d74
>> ["efi: honour memory reservations passed via a linux specific config
>> table"]), we hit a panic while trying to boot the kdump kernel on
>> machines which have large number of CPUs.
>>
> 
> Just for my understanding: why do you boot all 224 CPus when running
> the crash kernel?

FWIW, I've used these patches to kexec a kernel on a 256 CPUs system,
without any issue. Why am I not seeing this problem?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
