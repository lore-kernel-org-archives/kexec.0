Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-iw0-f177.google.com ([209.85.214.177])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1PiWlI-0004su-KN
	for kexec@lists.infradead.org; Thu, 27 Jan 2011 18:40:05 +0000
Received: by iwn38 with SMTP id 38so2334924iwn.36
	for <kexec@lists.infradead.org>; Thu, 27 Jan 2011 10:40:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <ih8he2$41t$2@dough.gmane.org>
References: <20110119222630.6755.63928.stgit@paris.rdu.redhat.com>
	<ih8gpe$41t$1@dough.gmane.org> <ih8he2$41t$2@dough.gmane.org>
Date: Thu, 27 Jan 2011 13:40:02 -0500
Message-ID: <AANLkTi=LJWvT5r=0rSBxV4aQdm6n2YAS_0y0RkKdTXQp@mail.gmail.com>
Subject: Re: [PATCH] kexec: include sysctl to disable
From: Eric Paris <eparis@parisplace.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: WANG Cong <xiyou.wangcong@gmail.com>, Eric Paris <eparis@redhat.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>

Ping, not hearing any argument is usually a good thing   :)

-Eric

On Thu, Jan 20, 2011 at 12:32 AM, WANG Cong <xiyou.wangcong@gmail.com> wrot=
e:

>> On Wed, 19 Jan 2011 17:26:30 -0500, Eric Paris wrote:
>>
>>> much like /proc/sys/kernel/modules_disable is used to disable module
>>> loading, /proc/sys/kernel/kexec_disable is used to disable kexec code
>>> loading. =A0It would still be possible to use kexec -l to load a kernel,
>>> set the tunable to 1 so the kernel waiting to boot couldn't change, and
>>> then launch the kernel at a later time (through kexec -e or through a
>>> crash)

> Acked-by: WANG Cong <xiyou.wangcong@gmail.com>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
