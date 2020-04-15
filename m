Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20200326180730.4754-1-james.morse@arm.com>
 <20200326180730.4754-3-james.morse@arm.com>
Date: Wed, 15 Apr 2020 15:36:12 -0500
In-Reply-To: <20200326180730.4754-3-james.morse@arm.com> (James Morse's
 message of "Thu, 26 Mar 2020 18:07:29 +0000")
Message-ID: <873694h4g3.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/3] mm/memory_hotplug: Allow arch override of non boot
 memory resource names
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
To: James Morse <james.morse@arm.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Bhupesh Sharma <bhsharma@redhat.com>, kexec@lists.infradead.org, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org

James Morse <james.morse@arm.com> writes:

> Memory added to the system by hotplug has a 'System RAM' resource created
> for it. This is exposed to user-space via /proc/iomem.
>
> This poses problems for kexec on arm64. If kexec decides to place the
> kernel in one of these newly onlined regions, the new kernel will find
> itself booting from a region not described as memory in the firmware
> tables.
>
> Arm64 doesn't have a structure like the e820 memory map that can be
> re-written when memory is brought online. Instead arm64 uses the UEFI
> memory map, or the memory node from the DT, sometimes both. We never
> rewrite these.
>
> Allow an architecture to specify a different name for these hotplug
> regions.

Gah.  No.

Please find a way to pass the current memory map to the loaded kexec'd
kernel.

Starting a kernel with no way for it to know what the current memory map
is just plain scary.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
