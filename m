Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U0fsG-0001bw-T9
 for kexec@lists.infradead.org; Wed, 30 Jan 2013 22:11:21 +0000
Message-ID: <51099A81.9090702@zytor.com>
Date: Wed, 30 Jan 2013 14:11:13 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH v8 3/7] kexec, x86: clean boot_params area for entry-32bit
 path
References: <1359581120-24397-1-git-send-email-yinghai@kernel.org>
 <1359581120-24397-4-git-send-email-yinghai@kernel.org>
 <510991F3.9020006@zytor.com>
 <CAE9FiQXaTkgmJbQ_6ZacwPx=2v+8XV0HBChtx+pE0agc=QkAjg@mail.gmail.com>
In-Reply-To: <CAE9FiQXaTkgmJbQ_6ZacwPx=2v+8XV0HBChtx+pE0agc=QkAjg@mail.gmail.com>
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
To: Yinghai Lu <yinghai@kernel.org>
Cc: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>

On 01/30/2013 02:09 PM, Yinghai Lu wrote:
> 
> yes.
> 
> how about clear all and copy only setup_header?
> 
> that looks more readable.
> 

Yes, and that is the recommended procedure anyway.

	-hpa


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
