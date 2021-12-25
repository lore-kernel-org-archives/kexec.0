Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 0/4] kdump: add parse_crashkernel_high_low() to replace
 parse_crashkernel_{high|low}()
Date: Sat, 25 Dec 2021 15:23:23 +0800
Message-ID: <20211225072327.1807-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
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
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc: Zhen Lei <thunder.leizhen@huawei.com>, Randy Dunlap <rdunlap@infradead.org>, Feng Zhou <zhoufeng.zf@bytedance.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Chen Zhou <dingguo.cz@antgroup.com>, John
 Donnelly <John.p.donnelly@oracle.com>

The bootup command line option crashkernel=Y,low is valid only when
crashkernel=X,high is specified. Putting their parsing into a separate
function makes the code logic clearer and easier to understand the strong
dependencies between them. So add parse_crashkernel_high_low() and use it
to repalce parse_crashkernel_{high|low}(). Then make the latter static,
and reduce two confusing parameters 'system_ram' and 'crash_base' of them.

All four patches in this series do the cleanups, no functional change. This
patchset is also a preparation for supporting reserve crashkernel above 4G
on arm64, and share code with x86.

The main proposal was made by Borislav Petkov.
> As I've already alluded to in another mail, ontop of this there should
> be a patch or multiple patches which clean this up more and perhaps even
> split it into separate functions doing stuff in this order:
>
> 1. Parse all crashkernel= cmdline options
> 2. Do all crash_base, crash_size etc checks
> 3. Do the memory reservations
>
> And all that supplied with comments explaining why stuff is being done.


Zhen Lei (4):
  kdump: add helper parse_crashkernel_high_low()
  x86/setup: Use parse_crashkernel_high_low() to simplify code
  kdump: make parse_crashkernel_{high|low}() static
  kdump: reduce unnecessary parameters of parse_crashkernel_{high|low}()

 arch/x86/kernel/setup.c    | 21 +++++++--------
 include/linux/crash_core.h |  7 +++--
 kernel/crash_core.c        | 54 +++++++++++++++++++++++++++++++-------
 3 files changed, 56 insertions(+), 26 deletions(-)

-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
