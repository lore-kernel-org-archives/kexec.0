Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from cavan.codon.org.uk ([2a00:1098:0:80:1000:c:0:1])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vln3u-0002kd-4c
 for kexec@lists.infradead.org; Wed, 27 Nov 2013 21:54:22 +0000
Date: Wed, 27 Nov 2013 21:53:09 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] PCI: Clear Bus Master bit only on kexec reboot
Message-ID: <20131127215309.GA15320@srcf.ucam.org>
References: <1385579908-24608-1-git-send-email-khalid.aziz@oracle.com>
 <87ob55my8z.fsf@xmission.com> <52964F2C.1020803@oracle.com>
 <20131127212227.GA31237@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131127212227.GA31237@kroah.com>
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
To: Greg KH <gregkh@linuxfoundation.org>
Cc: cl91tp@gmail.com, tianyu.lan@intel.com, indou.takao@jp.fujitsu.com, gnomes@lxorguk.ukuu.org.uk, linux-pci@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, f.otti@gmx.at, Khalid Aziz <khalid.aziz@oracle.com>, khlebnikov@openvz.org, "Eric W. Biederman" <ebiederm@xmission.com>, jility09@gmail.com, bhelgaas@google.com

On Wed, Nov 27, 2013 at 01:22:27PM -0800, Greg KH wrote:

> Then fix the drivers please.  It's not as if you don't have access to
> the source for them all...

Define "fix". It's clearly wrong to disable busmastering at shutdown on 
some devices, otherwise we wouldn't be having this discussion at all.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
