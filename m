Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73] helo=mx1.redhat.com)
 by casper.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1eqwfM-00007u-JU
 for kexec@lists.infradead.org; Wed, 28 Feb 2018 08:00:47 +0000
Date: Wed, 28 Feb 2018 16:00:12 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [RESEND makedumpfile PATCH 0/2] Add 5-level paging support
Message-ID: <20180228080012.GB30207@localhost.localdomain>
References: <20180228071308.17854-1-douly.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180228071308.17854-1-douly.fnst@cn.fujitsu.com>
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
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: mas-tachibana@vf.jp.nec.com, indou.takao@jp.fujitsu.com, kexec@lists.infradead.org, mas-hayashi@tg.jp.nec.com

Hi dou,

On 02/28/18 at 03:13pm, Dou Liyang wrote:
> this patchset adds 5-level paging support in makedumpfile
> 
>  -the 1th patch does some cleanup for the preparation of 5-level page tables support
>  -the 2th patch add the 5-level page tables support
> 
> Dou Liyang (2):
>   arch/x86_64: Cleanup the address translation of the 4-level page
>     tables
>   arch/x86_64: Add 5-level paging support

It doesn't work on my qemu+la57, kernel 4.16-rc1+. Not sure what kernel
you are testing, it truly works on kernel 4.16-rc1+ when cpu la57 is not
supported?

Thanks
Baoquan

> 
>  arch/x86_64.c  | 131 +++++++++++++++++++++++++++++++++++++++++----------------
>  makedumpfile.h |  38 +++++++++++------
>  2 files changed, 120 insertions(+), 49 deletions(-)
> 
> -- 
> 2.14.3
> 
> 
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
