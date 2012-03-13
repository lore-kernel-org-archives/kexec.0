Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1S7WOJ-0005Je-Gl
 for kexec@lists.infradead.org; Tue, 13 Mar 2012 18:24:12 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1329989047-20378-1-git-send-email-zhenzhong.duan@oracle.com>
 <4F5EBAA7.50709@oracle.com>
Date: Tue, 13 Mar 2012 11:27:30 -0700
In-Reply-To: <4F5EBAA7.50709@oracle.com> (DuanZhenzhong's message of "Tue, 13
 Mar 2012 11:10:31 +0800")
Message-ID: <m1r4wwe4q5.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [PATCH] kexec: add further check to crashkernel
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
To: DuanZhenzhong <zhenzhong.duan@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

DuanZhenzhong <zhenzhong.duan@oracle.com> writes:

> From: Zhenzhong Duan <zhenzhong.duan@oracle.com>
>
> When add crashkernel=2M-256M, kernel don't give any warning.
> This is misleading sometimes.

That seems reasonable.

Andrew do you want to carry this one.  I don't have a good tree to stash
this in.

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
> ---
> kernel/kexec.c |    4 ++++
> 1 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index 7b08867..0a6d147 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -1359,6 +1359,10 @@ static int __init parse_crashkernel_simple(char 		*cmdline,
>
> 	if (*cur == '@')
> 		*crash_base = memparse(cur+1, &cur);
> +	else if (*cur != ' ' && *cur != '\0') {
> +		pr_warning("crashkernel: unrecognized char\n");
> +		return -EINVAL;
> +	}
>
> 	return 0;
> }
> -- 1.7.3

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
