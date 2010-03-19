Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NsixC-0000fh-Fs
	for kexec@lists.infradead.org; Fri, 19 Mar 2010 20:38:02 +0000
Subject: Re: [PATCH 6/6] kexec-tools: Use default rpmbuild definations
References: <cover.1268942234.git.ameya.palande@nokia.com>
	<cover.1268942234.git.ameya.palande@nokia.com>
	<fd9d828f07e6cb070f73872d4427c865e52c5127.1268942234.git.ameya.palande@nokia.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 19 Mar 2010 13:37:50 -0700
In-Reply-To: <fd9d828f07e6cb070f73872d4427c865e52c5127.1268942234.git.ameya.palande@nokia.com>
	(Ameya Palande's message of "Thu\, 18 Mar 2010 22\:03\:24 +0200")
Message-ID: <m1634s9hep.fsf@fess.ebiederm.org>
MIME-Version: 1.0
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
To: Ameya Palande <2ameya@gmail.com>
Cc: horms@verge.net.au, kexec@lists.infradead.org

Ameya Palande <2ameya@gmail.com> writes:

> Since current mechanism for building rpm into custom directory is not working,
> remove it and switch to system defaults for rpmbuild.

Does RPM really bit rot that quickly?

I know at the time I added the code it was the only way I could
get rpm to build an rpm without being root.  Something that seems
desirable.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
