Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail.linuxfoundation.org ([140.211.169.12])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VlmZN-00029T-7o
 for kexec@lists.infradead.org; Wed, 27 Nov 2013 21:22:49 +0000
Date: Wed, 27 Nov 2013 13:22:27 -0800
From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] PCI: Clear Bus Master bit only on kexec reboot
Message-ID: <20131127212227.GA31237@kroah.com>
References: <1385579908-24608-1-git-send-email-khalid.aziz@oracle.com>
 <87ob55my8z.fsf@xmission.com> <52964F2C.1020803@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <52964F2C.1020803@oracle.com>
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
To: Khalid Aziz <khalid.aziz@oracle.com>
Cc: cl91tp@gmail.com, gnomes@lxorguk.ukuu.org.uk, indou.takao@jp.fujitsu.com, mjg59@srcf.ucam.org, linux-pci@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, f.otti@gmx.at, khlebnikov@openvz.org, "Eric W. Biederman" <ebiederm@xmission.com>, jility09@gmail.com, bhelgaas@google.com, tianyu.lan@intel.com

On Wed, Nov 27, 2013 at 12:59:40PM -0700, Khalid Aziz wrote:
> On 11/27/2013 12:38 PM, ebiederm@xmission.com wrote:
> >Khalid Aziz <khalid.aziz@oracle.com> writes:
> >
> >>Add a flag to tell the PCI subsystem that kernel is shutting down
> >>in prepapration to kexec a kernel. Add code in PCI subsystem to use
> >>this flag to clear Bus Master bit on PCI devices only in case of
> >>kexec reboot. This fixes https://bugzilla.kernel.org/show_bug.cgi?id=63861
> >>and avoids any other issues caused by clearing Bus Master bit on PCI
> >>devices in normal shutdown path. This patch is based on discussion at
> >>http://marc.info/?l=linux-pci&m=138425645204355&w=2
> >
> >Scratches head.
> >
> >Given that most devices already call pci_disable_device which clears the
> >bus master bit how does this change anything meaningful?
> >
> >Is is the problem here that most drivers are lazy and have a noop
> >shutdown method?
> 
> Yes, that is exactly the problem.

Then fix the drivers please.  It's not as if you don't have access to
the source for them all...

greg k-h

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
