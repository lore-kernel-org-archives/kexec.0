Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Mon, 10 Jun 2019 11:54:26 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v2 00/12] 52-bit kernel + user VAs
Message-ID: <20190610105425.d4vubtcknc2wn5uk@mbp>
References: <20190528161026.13193-1-steve.capper@arm.com>
 <762411c4-1148-a10e-2a79-d2c9e38bc46e@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <762411c4-1148-a10e-2a79-d2c9e38bc46e@redhat.com>
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
To: Bhupesh Sharma <bhsharma@redhat.com>
Cc: crecklin@redhat.com, ard.biesheuvel@linaro.org, marc.zyngier@arm.com, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Steve Capper <steve.capper@arm.com>, will.deacon@arm.com, linux-arm-kernel@lists.infradead.org

On Mon, Jun 10, 2019 at 04:10:50PM +0530, Bhupesh Sharma wrote:
> On 05/28/2019 09:40 PM, Steve Capper wrote:
> >   2) How can this memory map be advertised to kdump tools/documentation?
> >      I was planning on getting the kernel VA structure agreed on, then I
> >      would add the relevant exports/documentation.
> 
> Indeed, in the absence of corresponding changes to the Documentation
> section, it is hard to visualize the changes being made in the memory
> map.

We used to have some better documentation in the arm64 memory.txt until
commit 08375198b010 ("arm64: Determine the vmalloc/vmemmap space at
build time based on VA_BITS") which removed it in favour of what the
kernel was printing. Subsequently, the kernel VA layout printing was
also removed. It would be nice to bring back the memory.txt, even if it
is for a single configuration as per defconfig.

-- 
Catalin

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
