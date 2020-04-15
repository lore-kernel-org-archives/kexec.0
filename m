Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20200326180730.4754-1-james.morse@arm.com>
 <20200326180730.4754-4-james.morse@arm.com>
Date: Wed, 15 Apr 2020 15:37:32 -0500
In-Reply-To: <20200326180730.4754-4-james.morse@arm.com> (James Morse's
 message of "Thu, 26 Mar 2020 18:07:30 +0000")
Message-ID: <87v9m0fptf.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [PATCH 3/3] arm64: memory: Give hotplug memory a different
 resource name
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

> If kexec chooses to place the kernel in a memory region that was
> added after boot, we fail to boot as the kernel is running from a
> location that is not described as memory by the UEFI memory map or
> the original DT.
>
> To prevent unaware user-space kexec from doing this accidentally,
> give these regions a different name.

Please fix the problem and don't hack around it.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
