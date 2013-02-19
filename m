Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1U7wFx-0007D8-8Y
 for kexec@lists.infradead.org; Tue, 19 Feb 2013 23:05:50 +0000
Date: Tue, 19 Feb 2013 18:05:42 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 09/13] vmcore: copy ELF note segments in buffer on 2nd
 kernel
Message-ID: <20130219230542.GF6039@redhat.com>
References: <20130214100945.22466.4172.stgit@localhost6.localdomain6>
 <20130214101232.22466.44026.stgit@localhost6.localdomain6>
 <20130215165327.GH27784@redhat.com>
 <20130219.020234.255275278.d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130219.020234.255275278.d.hatayama@jp.fujitsu.com>
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

On Tue, Feb 19, 2013 at 02:02:34AM +0900, HATAYAMA Daisuke wrote:

[..]
> Anyway, what I'll do in the next version, are in summary:
> 
> - append pad notes in each notes on the 1st kernel in every
>   architectures, and
> - check if each note is in page-size boundary, and if not so, copy it
>   in the 2nd kernel and then append pad notes to it.

Makes sense to me. Most of the time first kernel and second kernel are
same so no copying of notes will take place. Only in corner cases of
older kernel being used as first kernel, copying will take place.

One other possibility is that deny mmap() if first kernel did not
prepare notes on page size boundary.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
