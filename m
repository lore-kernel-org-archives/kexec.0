Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ViPIe-00037N-Tq
 for kexec@lists.infradead.org; Mon, 18 Nov 2013 13:55:37 +0000
Date: Mon, 18 Nov 2013 08:55:11 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: /proc/vmcore mmap() failure issue
Message-ID: <20131118135511.GA30637@redhat.com>
References: <20131113204130.GD7613@redhat.com> <5284A689.70903@jp.fujitsu.com>
 <20131114151359.GA3913@redhat.com>
 <5285EC60.1060906@jp.fujitsu.com>
 <20131115142617.GC6637@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE971BF592@BPXM01GP.gisp.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE971BF592@BPXM01GP.gisp.nec.co.jp>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: "bhe@redhat.com" <bhe@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "d.hatayama@jp.fujitsu.com" <d.hatayama@jp.fujitsu.com>, "ebiederm@xmission.com" <ebiederm@xmission.com>, "dyoung@redhat.com" <dyoung@redhat.com>, "chaowang@redhat.com" <chaowang@redhat.com>

On Mon, Nov 18, 2013 at 12:51:39AM +0000, Atsushi Kumagai wrote:

[..]
> > Is there any chance that you could look into fixing this. I have no
> > experience writing code for makedumpfile.
> 
> I'll send a patch to fix this soon.

Thanks Atsushi.

Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
