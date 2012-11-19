Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TaUli-0000aj-A7
 for kexec@lists.infradead.org; Mon, 19 Nov 2012 17:04:23 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <878v9zp55t.fsf@xmission.com>
 <1353294278-32230-1-git-send-email-yinghai@kernel.org>
Date: Mon, 19 Nov 2012 09:04:02 -0800
In-Reply-To: <1353294278-32230-1-git-send-email-yinghai@kernel.org> (Yinghai
 Lu's message of "Sun, 18 Nov 2012 19:04:32 -0800")
Message-ID: <87lidx4j99.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2 0/6] kexec: put bzImage and ramdisk above 4G for x86
 64bit
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
Cc: Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, Vivek Goyal <vgoyal@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>

Yinghai Lu <yinghai@kernel.org> writes:

> Now we have limit kdump reserved under 896M, because kexec has the limitation.
> and also bzImage need to stay under 4g.

So this patchset is looking  a lot better.  I still have some nits to
pick with it.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
