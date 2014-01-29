Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W8K6E-0004rA-J4
 for kexec@lists.infradead.org; Wed, 29 Jan 2014 01:37:55 +0000
Message-ID: <52E85B26.2080203@cn.fujitsu.com>
Date: Wed, 29 Jan 2014 09:36:38 +0800
From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: More frequent kexec-tools releases
References: <20140128184042.GA7098@redhat.com>
In-Reply-To: <20140128184042.GA7098@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>, Simon Horman <horms@verge.net.au>
Cc: Dave Young <dyoung@redhat.com>, Kexec Mailing List <kexec@lists.infradead.org>, WANG Chao <chaowang@redhat.com>

Hello

On 01/29/2014 02:40 AM, Vivek Goyal wrote:
> Hi All,
> 
> Just now we were discussing that fedora kexec-tools should rebase to
> upstream kexec-tools every release so that we can test the latest code
> sooner.
> 
> Then Dave Young pulled in some data about the kexec-tools release
> duration.
> 
> Date:   Tue Mar 19 10:46:46 2013 +0900
>     kexec-tools 2.0.4 ~100 commits
> 
> Date:   Mon Jan 16 09:15:25 2012 +1100
>     kexec-tools 2.0.3 ~100 commits
> 
> Date:   Thu Jul 29 13:40:00 2010 +0900
>     kexec-tools 2.0.2 ~80 commits
> 
> Date:   Thu Aug 13 09:28:08 2009 +1000
>     kexec-tools 2.0.1 ~60 commits
> 
> Date:   Sat Jul 19 10:31:30 2008 +1000
>     kexec-tools 2.0.0
> 
> So that is 5 release in 5.5 years. It is roughly 1 release per year.
> 
> I am wondering if there is any interest in more frequent releases of
> kexec-tools. Say every 3 months or every 6 months.
> 
> IMHO, it might be better if there are more frequent release of kexec-tools
> (say a release every 6 months) and then every 6 months distributions
> should be able to rebase to that new release.
> 
> Thoughts?

Agreed. Sometimes, important changes in the kernel side will lead to the change
in the kexec-tools, so especially in this case, I think it might be better
to release a new version asap.

> 
> Thanks
> Vivek
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 


-- 
Thanks.
Zhang Yanfei

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
