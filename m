Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-vw0-f49.google.com ([209.85.212.49])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RTFbB-0001KD-O7
 for kexec@lists.infradead.org; Wed, 23 Nov 2011 16:23:03 +0000
Received: by vbbfs19 with SMTP id fs19so1796302vbb.36
 for <kexec@lists.infradead.org>; Wed, 23 Nov 2011 08:23:00 -0800 (PST)
Date: Wed, 23 Nov 2011 08:22:54 -0800
From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] percpu: add comment to per_cpu_ptr_to_phys
Message-ID: <20111123162254.GD25780@google.com>
References: <20111123084543.GA2923@darkstar.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20111123084543.GA2923@darkstar.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: xiyou.wangcong@gmail.com, kexec@lists.infradead.org, tim@edgecast.com, linux-kernel@vger.kernel.org

Hello,

On Wed, Nov 23, 2011 at 04:45:43PM +0800, Dave Young wrote:
> add comments about current per_cpu_ptr_to_phys implementation
> to explain why the logic is more complicated than necessary.
> 
> Signed-off-by: Dave Young <dyoung@redhat.com>

Moved the comment into the kerneldoc comment and applied to
percpu/for-3.2-fixes.

Thank you very much.

-- 
tejun

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
