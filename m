Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1QbXrO-0000r0-Mp
	for kexec@lists.infradead.org; Tue, 28 Jun 2011 12:57:47 +0000
Date: Tue, 28 Jun 2011 08:57:42 -0400 (EDT)
From: Dave Anderson <anderson@redhat.com>
Message-ID: <1035209833.226401.1309265862792.JavaMail.root@zmail05.collab.prod.int.phx2.redhat.com>
In-Reply-To: <20110628.164425.39157342.d.hatayama@jp.fujitsu.com>
Subject: Re: [Crash-utility] [RFI] Support Fujitsu's sadump dump format
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "Discussion list for crash utility usage,
	maintenance and development" <crash-utility@redhat.com>
Cc: kexec@lists.infradead.org



----- Original Message -----
> Fujitsu has stand-alone dump mechanism based on firmware level
> functionality, which we call SADUMP, in short.
> 
> We've maintained utility tools internally but now we're thinking that
> the best is crash utility and makedumpfile supports the sadump format
> for the viewpoint of both portability and maintainability.
> 
> We'll be of course responsible for its maintainance in a continuous
> manner. The sadump dump format is very similar to diskdump format and
> so kdump (compressed) format, so we estimate patch set would be a
> relatively small size.
> 
> Could you tell me whether crash utility and makedumpfile can support
> the sadump format? If OK, we'll start to make patchset.

Sure, yes, the crash utility can always support another dumpfile format.

It's unclear to me how similar SADUMP is to diskdump/compressed-kdump.
Does your internal version patch diskdump.c, or do you maintain your
own "sadump.c"?  I ask because if your patchset is at all intrusive,
I'd prefer it be kept in its own file, primarily for maintainability,
but also because SADUMP is essentially a black-box to anybody outside
Fujitsu.

Thanks,
  Dave

 
> Thanks.
> HATAYAMA, Daisuke

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
