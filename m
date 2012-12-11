Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TiYbO-0001wQ-4h
 for kexec@lists.infradead.org; Tue, 11 Dec 2012 22:47:03 +0000
Date: Tue, 11 Dec 2012 19:55:39 -0200
From: Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH] [RESEND] x86/kexec: crash_vmclear_local_vmcss needs __rcu
Message-ID: <20121211215539.GA4468@amt.cnet>
References: <50C18168.305@cn.fujitsu.com>
 <50C6F8C6.9000008@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <50C6F8C6.9000008@cn.fujitsu.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Gleb Natapov <gleb@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, kbuild test robot <fengguang.wu@intel.com>

On Tue, Dec 11, 2012 at 05:11:34PM +0800, Zhang Yanfei wrote:
> This removes the sparse warning:
> arch/x86/kernel/crash.c:49:32: sparse: incompatible types in comparison expression (different address spaces)
> 
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
> ---
>  arch/x86/include/asm/kexec.h |    3 ++-
>  arch/x86/kernel/crash.c      |    4 ++--
>  2 files changed, 4 insertions(+), 3 deletions(-)

Applied, thanks.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
