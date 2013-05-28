Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UhLZB-0008Vk-SY
 for kexec@lists.infradead.org; Tue, 28 May 2013 15:12:02 +0000
Message-ID: <51A4C926.2040701@zytor.com>
Date: Tue, 28 May 2013 08:11:34 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH 0/7] Remove unused /dev/oldmem interface
References: <51A02E50.5020507@gmail.com> <87mwri8wwu.fsf@xmission.com>
 <20130528143756.GD7088@redhat.com>
In-Reply-To: <20130528143756.GD7088@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Simon Horman <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Zhang Yanfei <zhangyanfei.yes@gmail.com>

On 05/28/2013 07:37 AM, Vivek Goyal wrote:
> 
> Eric,
> 
> Should we schedule the removal of this interface after 1-2 releases
> and give a warning once if anybody opens /dev/oldmem and tell them
> to use /proc/vmcore instead? 
> 
> I am kind of inclined towards warning approarch. If there is any xyz
> /dev/oldmem user in the wild out there, he/she atleast gets a chance to
> migrate to /proc/vmcore.
> 

This has been discussed ad nauseam at the Kernel Summit.  It doesn't work.

	-hpa



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
