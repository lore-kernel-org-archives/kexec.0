Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XU5L9-0000sh-GD
 for kexec@lists.infradead.org; Wed, 17 Sep 2014 02:51:31 +0000
Message-ID: <5418F4D8.2070301@cn.fujitsu.com>
Date: Wed, 17 Sep 2014 10:41:28 +0800
From: "Wang, Xiao/Wang Xiao" <wangx.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] makedumpfile: make the incomplete vmcore generated
 by ENOSPC error analyzable
References: <mailman.12983.1410860958.22890.kexec@lists.infradead.org>
 <1344663963.15300444.1410873613602.JavaMail.zimbra@redhat.com>
In-Reply-To: <1344663963.15300444.1410873613602.JavaMail.zimbra@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Dave Anderson <anderson@redhat.com>, kexec@lists.infradead.org

Hello Dave,

Thanks for your reply.

We can use two methods to indicate that the incomplete vmcore is a 
"fixed" one,
1. Use a flag in elf/kdump dumpfile(like "e_flags" in ELF header and 
"status"
    in disk_dump_header) to indicate it has been "fixed". But actually the
    kdump-compressed file needn't to use such a flag, for we just change the
    data write order of this format.
2. We can just let makedumpfile change the "fixed" dumpfile's filename 
automatically.
    Such as add a "-truncated" flag after those dumpfiles.

On 2014/9/16 21:20, Dave Anderson wrote:
> This patch bothers me -- how would the crash utility know that the "fixed"
> vmcore file was truncated/bogus to begin with?  Are you simply presuming
> that the user (when running makedumpfile) will change the output dumpfile
> name to something that indicates that it's incomplete?
>
> Typically incomplete vmcores fail to initialize due to some missing data,
> and it will confuse the issue if the PT_LOAD segments indicate that everything
> is just fine.  There really should be some kind of indication/flag/note in the
> compressed dumpfile or ELF header that it's a bogus/truncated vmcore.

-- 
Regards
Wang Xiao

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
