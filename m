Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail.linuxfoundation.org ([140.211.169.12])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VsinE-00035D-Nj
 for kexec@lists.infradead.org; Tue, 17 Dec 2013 00:45:49 +0000
Date: Mon, 16 Dec 2013 16:45:23 -0800
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/4] kexec: Simplify conditional
Message-Id: <20131216164523.91cf29d974ca7424491adb8d@linux-foundation.org>
In-Reply-To: <52A91212.9080501@cn.fujitsu.com>
References: <cover.1386807069.git.geoff@infradead.org>
 <839896bb375c8b694473b0ea6a6db009c1128fc5.1386807069.git.geoff@infradead.org>
 <52A91212.9080501@cn.fujitsu.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
Cc: Geoff Levand <geoff@infradead.org>, kexec@lists.infradead.org, Eric Biederman <ebiederm@xmission.com>

On Thu, 12 Dec 2013 09:32:02 +0800 Zhang Yanfei <zhangyanfei@cn.fujitsu.com> wrote:

> Add CCing Andrew Morton

I'm not on kexec@lists.infradead.org.  (Well, I am now!).

> On 12/12/2013 08:18 AM, Geoff Levand wrote:
> > Simplify the code around one of the conditionals in the kexec_load
> > syscall routine.
> > 
> > The original code was confusing with a redundant check on KEXEC_ON_CRASH
> > and comments outside of the conditional block.  This change switches the
> > order of the conditional check, and cleans up the comments for the
> > conditional.  There is no functional change to the code.
> 
> This looks good.
> 
> Reviewed-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
>
> minor comments below.

Please cc me on the resend?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
