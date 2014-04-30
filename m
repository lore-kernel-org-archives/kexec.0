Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WfT4s-0000lB-2T
 for kexec@lists.infradead.org; Wed, 30 Apr 2014 11:53:30 +0000
Date: Wed, 30 Apr 2014 13:53:04 +0200
From: Petr Tesarik <ptesarik@suse.cz>
Subject: Re: [PATCH 0/4] Replace lseek..write/read to pwrite/pread
Message-ID: <20140430135304.3c7e7ed5@hananiah.suse.cz>
In-Reply-To: <20140430.204138.209328404.d.hatayama@jp.fujitsu.com>
References: <1398485229-43295-1-git-send-email-wangnan0@huawei.com>
 <20140430.204138.209328404.d.hatayama@jp.fujitsu.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: wangnan0@huawei.com, kumagai-atsushi@mxc.nes.nec.co.jp, kexec@lists.infradead.org, sdu.liu@huawei.com, hui.geng@huawei.com

On Wed, 30 Apr 2014 20:41:38 +0900 (JST)
HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:

> From: Wang Nan <wangnan0@huawei.com>
> Subject: [PATCH 0/4] Replace lseek..write/read to pwrite/pread
> Date: Sat, 26 Apr 2014 12:07:05 +0800
> 
> > In original code there are many operations read from /write to specific
> > positions of a file. This series of patches replace such patterns to
> > pread/pwrite calls, reduces more than 100 lines of code.
> > 
> 
> I'm now writing pthread support patch set and it will naturally
> include pread/pwrite like this patch set.
> 
> It sounds to me that using pread/pwrite only to reduce lseek code is
> weak in motivation. Is there another visible merit? For example, any
> kind of performance improvement. I guess it's small even if exists
> compared to I/O.

There is no user-visible benefit just from applying the patch, that's
right.

The main benefit is that these pread/pwrite operations are atomic and do
not move the file offset, so all subprocesses (or threads) can share
the same file descriptor. This allows to remove reopen_dump_memory(),
for example.

Anyway, is improving code readability really so weak argument?

Petr T

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
