Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: James Morse <james.morse@arm.com>
Subject: Re: [PATCH v3 02/17] arm64, hibernate: use get_safe_page directly
References: <20190821183204.23576-1-pasha.tatashin@soleen.com>
 <20190821183204.23576-3-pasha.tatashin@soleen.com>
Message-ID: <dc6506a0-9b66-f633-8319-9c8a9dc93d4f@arm.com>
Date: Fri, 6 Sep 2019 16:17:25 +0100
MIME-Version: 1.0
In-Reply-To: <20190821183204.23576-3-pasha.tatashin@soleen.com>
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
Cc: sashal@kernel.org, mark.rutland@arm.com, vladimir.murzin@arm.com, corbet@lwn.net, marc.zyngier@arm.com, catalin.marinas@arm.com, bhsharma@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, jmorris@namei.org, linux-mm@kvack.org, ebiederm@xmission.com, matthias.bgg@gmail.com, will@kernel.org, linux-arm-kernel@lists.infradead.org

Hi Pavel,

Nit: The pattern for the subject prefix should be "arm64: hibernate:"..
Its usually possible to spot the pattern from "git log --oneline $file".

On 21/08/2019 19:31, Pavel Tatashin wrote:
> create_safe_exec_page is a local function that uses the
> get_safe_page() to allocate page table and pages and one pages
> that is getting mapped.

I can't parse this.

create_safe_exec_page() uses hibernate's allocator to create a set of page table to map a
single page that will contain the relocation code.


> Remove the allocator related arguments, and use get_safe_page
> directly, as it is done in other local functions in this
> file.
... because kexec can't use this as it doesn't have a working allocator.
Removing this function pointer makes it easier to refactor the code later.

(this thing is only a function pointer so kexec could use it too ... It looks like you're
creating extra work. Patch 7 moves these new calls out to a new file... presumably so
another patch can remove them again)

As stand-alone cleanup the patch looks fine, but you probably don't need to do this.


Thanks,

James

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
