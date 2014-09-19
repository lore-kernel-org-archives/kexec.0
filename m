Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XUuJI-000843-4r
 for kexec@lists.infradead.org; Fri, 19 Sep 2014 09:17:00 +0000
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (localhost.localdomain
 [127.0.0.1])
 by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s8J9GcNe022352
 for <kexec@lists.infradead.org>; Fri, 19 Sep 2014 17:16:38 +0800
Message-ID: <541BF470.3050603@cn.fujitsu.com>
Date: Fri, 19 Sep 2014 17:16:32 +0800
From: "Wang, Xiao/Wang Xiao" <wangx.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] makedumpfile: make the incomplete vmcore generated
 by ENOSPC error analyzable
References: <54180781.2080702@cn.fujitsu.com> <541AD00F.1070004@jp.fujitsu.com>
In-Reply-To: <541AD00F.1070004@jp.fujitsu.com>
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
To: "HATAYAMA, Daisuke" <d.hatayama@jp.fujitsu.com>
Cc: kexec@lists.infradead.org

Hello HATAYAMA,

On 2014/9/18 20:29, HATAYAMA, Daisuke wrote:
> Rigorously, this design depends on implementation of filesystems where it's
> possible to lseek and write data onto already allocated blocks even
> after the
> filesystem is full. To show correctness of this design, you should show
> that
> test results for a variety of filesystems such as ext3, ext4, xfs,
> btrfs, etc.

Actually, I've tested whether lseek and write can execute on those 
filesystems(
ext2, ext3, ext4, xfs, and btrfs) when there's no more space, and both 
of these
two system calls can work well on all of those filesystems(the snapshot 
function
of btrfs may be confused, but it just need to allocate diskspace when 
creating
snapshot and will never aquire more diskspace automically in the 
future). But
I couldn't get any test results of these testing, because there's no error
message when doing such tests.

>
> Of course, if this design doesn't work well on some filesystem, then we
> just
> see the second ENOSPC and we give up addtional work. This is the same
> situation
> as now. There's no demerit.

As you said, this design won't introduce any more errors. So the influence
of the filesystem is very limited.

PS: the modified patches(according to you and Dave's comments) will be send
later.

-- 
Regards
Wang Xiao

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
