Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TJONB-0001Qr-Mc
 for kexec@lists.infradead.org; Wed, 03 Oct 2012 12:48:23 +0000
Date: Wed, 3 Oct 2012 08:48:13 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: makedumpfile 1.5.0 takes much more time to dump
Message-ID: <20121003124813.GB20376@redhat.com>
References: <20120920200633.GL4681@redhat.com>
 <20120921.092357.94103398.d.hatayama@jp.fujitsu.com>
 <20120921133232.GC15909@redhat.com>
 <20120924.095112.153507503.d.hatayama@jp.fujitsu.com>
 <20120924145157.GA14886@redhat.com>
 <20121003163835.c4be2b609deb385aab247beb@mxc.nes.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20121003163835.c4be2b609deb385aab247beb@mxc.nes.nec.co.jp>
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
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: kexec@lists.infradead.org, d.hatayama@jp.fujitsu.com, dyoung@redhat.com, chaowang@redhat.com

On Wed, Oct 03, 2012 at 04:38:35PM +0900, Atsushi Kumagai wrote:

[..]
> > > If that's going to take time, can we make using of new logic conditional
> > > on a command line option. So that user has the option of using old
> > > logic.
> > > 
> > 
> > Kumagai-san should decide this. 
> 
> I'm not planning to make the cyclic mode optional.
> However, I think the performance issue should be improved even without
> mem_map array logic.
> 
> So, I will try to reduce the number of cycles as few times as possible for v1.5.1,
> the performance issue will be improved.
> To make sure of it, would you re-test with --cyclic-buffer 32768 (32MB), Vivek ?
> Then the result of v1.5.0 is still too bad, I will consider using the old logic 
> as default logic.

Actually chaowang did the testing. In the bug he provided data for 16MB
buffer.

makedumpfile with 16M cyclic buffer,
#1. makedumpfile-1.5.0 -c --message-level 1 -d 31 --cyclic-buffer 16384
real     12m51.886s
user     6m30.710s
sys      6m11.642s
#2. makedumpfile-1.5.0 -E --message-level 1 -d 31 --cyclic-buffer 16384
real     11m24.141s
user     4m25.897s
sys      6m38.116s

Which looks much better than default numbers. Chao, can you please do the
testing with 32MB buffer size and provide the data here.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
