Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1SHK5m-0004cC-V3
 for kexec@lists.infradead.org; Mon, 09 Apr 2012 19:17:36 +0000
Date: Mon, 9 Apr 2012 14:57:28 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: makedumpfile memory usage grows with system memory size
Message-ID: <20120409185728.GH1645@redhat.com>
References: <20120405143439.GA23999@redhat.com>
 <20120406.101212.193682065.d.hatayama@jp.fujitsu.com>
 <20120406175924.007450fe.kumagai-atsushi@mxc.nes.nec.co.jp>
 <20120406.182940.310075868.d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20120406.182940.310075868.d.hatayama@jp.fujitsu.com>
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
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: dzickus@redhat.com, oomichi@mxs.nes.nec.co.jp, kumagai-atsushi@mxc.nes.nec.co.jp, kexec@lists.infradead.org

On Fri, Apr 06, 2012 at 06:29:40PM +0900, HATAYAMA Daisuke wrote:

[..]
> I agree. On the other hand, there is one more thing to consider. The
> value of order is in private member of the page descripter. Now
> there's no information for private member in VMCOREINFO. If we choose
> this method and delete the current one, it's necessary to prepare
> vmlinux file for old kernels.

What information do you need to access "private" member of "struct page".
offset? Can't we extend VMCOREINFO to export this info too?

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
