Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1U7wHR-0007Ne-8U
 for kexec@lists.infradead.org; Tue, 19 Feb 2013 23:07:21 +0000
Date: Tue, 19 Feb 2013 18:07:17 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 04/13] vmcore: introduce types for objects copied in 2nd
 kernel
Message-ID: <20130219230717.GG6039@redhat.com>
References: <20130214100945.22466.4172.stgit@localhost6.localdomain6>
 <20130214101205.22466.5909.stgit@localhost6.localdomain6>
 <20130215152828.GC27784@redhat.com>
 <20130219.010631.336702748.d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130219.010631.336702748.d.hatayama@jp.fujitsu.com>
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
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, kumagai-atsushi@mxc.nes.nec.co.jp, ebiederm@xmission.com, cpw@sgi.com

On Tue, Feb 19, 2013 at 01:06:31AM +0900, HATAYAMA Daisuke wrote:

[..]
> This sounds strange to me. There has not been contents to be fetched
> from current kenrel so far. So, object with MEM_TYPE_OLDMEM seems more
> normal than without. Should we prepare special type for objects in 2nd
> kernel?

Creating a flag for memory in current kernel and if flag is not set, then
assuming memory comes from old kernel is fine too.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
