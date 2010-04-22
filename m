Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1O4wZN-0003TN-2i
	for kexec@lists.infradead.org; Thu, 22 Apr 2010 13:35:53 +0000
Subject: Re: Kexec for ARM: Is it expected to load old kernels?
References: <4BBFC9F5.3070105@anabaptists.org>
	<n2id1b08f941004120500o43859311x8331038ceb84d1b7@mail.gmail.com>
	<4BC3339C.9040903@anabaptists.org> <4BC5F4E9.2000808@anabaptists.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 22 Apr 2010 06:35:44 -0700
In-Reply-To: <4BC5F4E9.2000808@anabaptists.org> (Brian Smucker's message of
	"Wed\, 14 Apr 2010 10\:01\:29 -0700")
Message-ID: <m18w8fzk27.fsf@fess.ebiederm.org>
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
To: Brian Smucker <bsmucker@anabaptists.org>
Cc: kexec@lists.infradead.org

Brian Smucker <bsmucker@anabaptists.org> writes:

> Hello,
>
> Is there someone who can answer these questions out there?
>
> Perhaps you could give a name of someone who could help.

kexec is designed to boot arbitrary kernels.  How well you can do that
depends on how close the system can be returned to a state similar to
reset, and how robust the kernel you are booting is.

If you can get /sbin/kexec to reproduce your normal boot protocol it
is likely you can get an newer kernel to boot an older one.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
