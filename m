Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
MIME-Version: 1.0
References: <b0443908-e36f-9bc4-4a8a-4206cb782d4b@arm.com>
 <72672e2c-a57a-8df9-0cff-8035cbce7740@redhat.com>
 <34274b02-60ba-eb78-eacd-6dc1146ed3cd@arm.com>
 <80e4d1d7-f493-3f66-f700-86f18002d692@redhat.com>
 <dfacf85f-d79d-8742-7a13-1ac0a67bad04@arm.com>
 <ba481c82-c69e-043c-4b66-2d2c7732cf07@redhat.com>
 <20200410121013.03b609fd572504c03a666f4a@linux-foundation.org>
 <20200411034414.GH2129@MiWiFi-R3L-srv>
 <20200411093009.GH25745@shell.armlinux.org.uk>
 <20200412053507.GA4247@MiWiFi-R3L-srv>
 <20200412080836.GM25745@shell.armlinux.org.uk>
 <87wo6klbw0.fsf@x220.int.ebiederm.org>
In-Reply-To: <87wo6klbw0.fsf@x220.int.ebiederm.org>
From: Bhupesh SHARMA <bhupesh.linux@gmail.com>
Date: Mon, 13 Apr 2020 02:07:58 +0530
Message-ID: <CAFTCetT=7rYm_yPSZWjT=+fKPujuqwKyY_2aBcAR17AifuHaoA@mail.gmail.com>
Subject: Re: [PATCH 1/3] kexec: Prevent removal of memory in use by a loaded
 kexec image
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Baoquan He <bhe@redhat.com>, Anshuman Khandual <anshuman.khandual@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Bhupesh Sharma <bhsharma@redhat.com>, David Hildenbrand <david@redhat.com>, kexec@lists.infradead.org, Russell King - ARM Linux admin <linux@armlinux.org.uk>, linux-mm@kvack.org, James Morse <james.morse@arm.com>, Andrew Morton <akpm@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org

On Mon, Apr 13, 2020 at 1:26 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
>
> The only benefit of kexec_file_load is that it is simple enough from a
> kernel perspective that signatures can be checked.
>
> kexec_load in every other respect is the more capable and functional
> interface.  It makes no sense to get rid of it.
>
> It does make sense to reload with a loaded kernel on memory hotplug.
> That is simple and easy.  If we are going to handle something in the
> kernel it should simple an automated unloading of the kernel on memory
> hotplug.
>
>
> I think it would be irresponsible to deprecate kexec_load on any
> platform.
>
> I also suspect that kexec_file_load could be taught to copy the dtb
> on arm32 if someone wants to deal with signatures.
>
> We definitely can not even think of deprecating kexec_load until
> architecture that supports it also supports kexec_file_load and everyone
> is happy with that interface.  That is Linus's no regression rule.

TBH, I have seen several active users of kexec_load on arm32
environments and we have been trying to help them with kexec issues on
arm32 in recent past as well.

So, I agree with Eric's view that probably deprecating this in favour
of kexec_file_load will break these existing environment.

I tried to do some work at the start of this year to add
kexec_file_load support for arm32 in my spare cycles, but I gave up as
the arm32 hardware had a broken firmware and couldn't boot latest
upstream kernel.

May be I try to find some spare cycles in the coming days to do it.

But I think since kexec_load is an important interface on these arm32
boards for supporting existing kexec-based bootloaders, we should
continue supporting the same until kexec_file_load is supported/mature
enough for arm32.

Thanks,
Bhupesh

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
