Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UhixZ-0001vk-7E
 for kexec@lists.infradead.org; Wed, 29 May 2013 16:10:45 +0000
Date: Wed, 29 May 2013 12:10:20 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 0/7] Remove unused /dev/oldmem interface
Message-ID: <20130529161020.GB22146@redhat.com>
References: <51A02E50.5020507@gmail.com> <87mwri8wwu.fsf@xmission.com>
 <20130528143756.GD7088@redhat.com>
 <ec5cd077-c314-49d5-8970-439ffb9539fa@email.android.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ec5cd077-c314-49d5-8970-439ffb9539fa@email.android.com>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Simon Horman <horms@verge.net.au>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Zhang Yanfei <zhangyanfei.yes@gmail.com>

On Tue, May 28, 2013 at 12:00:45PM -0700, Eric W. Biederman wrote:

[..]
> How can anyone use /dev/oldmem correctly?  To the best of
> my knowledge there are no parsers of the ELF header passed
> by /sbin/kexec in userspace.
> 
> If there is anyone who cares they can complain and we can
> revert the removal. All of the evidence is that everyone uses
> /proc/vmcore.
> 

Ok, that's fine. Given the fact that none of us has ever encountered
/dev/oldmem user, it is reasonably safe to remove it.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
