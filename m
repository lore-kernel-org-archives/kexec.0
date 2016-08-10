Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1470848093.19503.54.camel@infradead.org>
Subject: Re: [PATCH v3 2/3] arm64: Add arm64 kexec support
From: Geoff Levand <geoff@infradead.org>
Date: Wed, 10 Aug 2016 09:54:53 -0700
In-Reply-To: <20160810035743.GA27500@localhost.localdomain>
References: <cover.1470693832.git.geoff@infradead.org>
 <177affa377979b1f10d5bd39107b96fe506eb683.1470693832.git.geoff@infradead.org>
 <20160810035743.GA27500@localhost.localdomain>
Mime-Version: 1.0
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
To: Pratyush Anand <panand@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On Wed, 2016-08-10 at 09:27 +0530, Pratyush Anand wrote:
> This is what is being printed by kexec-tools:
> 
> elf_arm64_load: e_entry:       fffffc0008080000 -> 0000004000080000
> elf_arm64_load: p_vaddr:       fffffc0008080000 -> 0000004000080000
> elf_arm64_load: header_offset: 0000000000000000
> elf_arm64_load: text_offset:   0000000000080000
> elf_arm64_load: image_size:    00000000013a0000
> elf_arm64_load: phys_offset:   0000004000000000
> elf_arm64_load: page_offset:   fffffc0008000000
> 
> kernel is having 42 VA Bits, so a debug print in kernel says that
> PAGE_OFFSET=fffffe0000000000. Notice the difference between the values
> calculated by kernel and kexec-tools. Isn't it confusing? 

I renamed page_offset to vp_offset.

-Geoff

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
