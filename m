Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XOhkV-0007ju-V6
 for kexec@lists.infradead.org; Tue, 02 Sep 2014 06:39:28 +0000
Date: Tue, 2 Sep 2014 14:38:59 +0800
From: "bhe@redhat.com" <bhe@redhat.com>
Subject: Re: [PATCH v6 0/8] add a new interface to show the memory usage of
 1st kernel
Message-ID: <20140902063859.GD1725@dhcp-16-116.nay.redhat.com>
References: <1409541340-2719-1-git-send-email-bhe@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE972519FE@BPXM01GP.gisp.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE972519FE@BPXM01GP.gisp.nec.co.jp>
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
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "vgoyal@redhat.com" <vgoyal@redhat.com>

On 09/02/14 at 06:20am, Atsushi Kumagai wrote:
> Hello Baoquan,
> 

> >[patch 6/8] introduce-a-function-exclude_zero_pages_cyclic
> >v3->v4:
> >    Newly introduce a function exclude_zero_pages_cyclic(), and call it in
> >    get_num_dumpable_cyclic().
> >
> >    Besides, a strange thing happened when the new interface was tested on
> >    my local AMD machine. It always terminated and printed message:
> >    "Program terminated with signal SIGKILL"
> >    With gdb, it should be going in readmem() of exclude_zero_pages_cyclic, I
> >    still don't know why it happened.
> 
> This issue is still under investigation, but it may be a kernel issue
> since you just read a page of System RAM via /proc/kcore. At least your
> patches look good to me, I'll merge them into v1.5.7. Good job!

Hi Atsushi,

Thanks for help on this patchset.

For this issue happened on AMD machine, I will try to look into it deeper
later. Saw the mail you mentioned that someone has reported the simillar
bug, will check it.

Thanks
Baoquan


> 
> 
> Thanks
> Atsushi Kumagai
> 
> >

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
