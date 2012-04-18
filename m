Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1SKQCP-0003Cz-RE
 for kexec@lists.infradead.org; Wed, 18 Apr 2012 08:25:15 +0000
Message-ID: <4F8E7A5B.5030904@redhat.com>
Date: Wed, 18 Apr 2012 11:24:59 +0300
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH 0/4] Export offsets of VMCS fields as note information
 for kdump
References: <4F84E0DF.8040206@cn.fujitsu.com> <4F8D1F46.3090901@redhat.com>
 <4F8D4B4C.8070705@cn.fujitsu.com> <4F8D4D1C.4010400@redhat.com>
 <4F8E6DA5.8030503@cn.fujitsu.com>
In-Reply-To: <4F8E6DA5.8030503@cn.fujitsu.com>
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
To: zhangyanfei <zhangyanfei@cn.fujitsu.com>
Cc: dzickus@redhat.com, luto@mit.edu, gregkh@suse.de, kvm@vger.kernel.org, joerg.roedel@amd.com, mtosatti@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, paul.gortmaker@windriver.com, ludwig.nussel@suse.de, ebiederm@xmission.com

On 04/18/2012 10:30 AM, zhangyanfei wrote:
> > 
> > Okay.  Do you expect it to help in debugging the crash?  Did you have
> > cases where it would help?
> > 
>
> Yes, I do expect it to help in debugging the crash.
> Looking into host machine's crash dump, if we figure out the fact that the crash
> had happend when some host's resource was requested and used by some guset machine.
> Then, we surely want to look into the situation from guest machine's view.
>
>

What type of resource?  Can you give an example?

-- 
error compiling committee.c: too many arguments to function


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
