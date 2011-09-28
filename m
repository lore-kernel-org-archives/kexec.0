Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1R8tsU-00029W-7A
	for kexec@lists.infradead.org; Wed, 28 Sep 2011 13:08:47 +0000
Date: Wed, 28 Sep 2011 09:08:42 -0400
From: Don Zickus <dzickus@redhat.com>
Subject: Re: rhel5.6 kdump initrd problem?
Message-ID: <20110928130842.GP5795@redhat.com>
References: <4E821824.7090900@sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4E821824.7090900@sgi.com>
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
To: Jay Lan <jlan@sgi.com>
Cc: kexec@lists.infradead.org

On Tue, Sep 27, 2011 at 11:38:28AM -0700, Jay Lan wrote:
> Hi all,
> 
> I have a system running 2.6.18-238.12.1.el5 kernel.
> The kexec version is kexec-tools-1.102pre-126.el5_6.6.
> 
> The kernel was booted OK. Then it ran /etc/init.d/kdump
> and a new kdump initrd image was created.
> A kernel crash was triggered. The kdump kernel was booted
> alright. However, it failed to boot when it tried to boot
> back the regular kernel (now with the kdump initrd image
> specified in the menu.lst.)

Not sure why you would see the kdump initrd image in the menu.lst, it is
just a parameter sent to kexec.

You might have more success filing a Red Hat bz (bugzilla.redhat.com), as
the RHEL-5 kernel and kexec-tools are probably too old for discussion on
this list.

Cheers,
Don

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
