Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Z5rVg-0002HC-C4
 for kexec@lists.infradead.org; Fri, 19 Jun 2015 08:18:48 +0000
Date: Fri, 19 Jun 2015 16:18:16 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: kexec_load(2) bypasses signature verification
Message-ID: <20150619081816.GK4636@dhcp-128-32.nay.redhat.com>
References: <CA+5PVA6YKR_=uVpM2rW4et3YCJLh9c+uuxt2koH1Fy2ZuR7W-g@mail.gmail.com>
 <20150615200115.GG5003@thunk.org>
 <87zj3zigug.fsf@x220.int.ebiederm.org>
 <20150616202757.GB14943@redhat.com>
 <87y4jjglvu.fsf@x220.int.ebiederm.org>
 <20150617014737.GB30214@redhat.com>
 <20150618011629.GA8718@dhcp-128-32.nay.redhat.com>
 <20150618020209.GA8390@dhcp-128-32.nay.redhat.com>
 <20150618133044.GA1040@redhat.com>
 <20150619062140.GH4636@dhcp-128-32.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150619062140.GH4636@dhcp-128-32.nay.redhat.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Josh Boyer <jwboyer@fedoraproject.org>, Theodore Ts'o <tytso@mit.edu>, kexec <kexec@lists.infradead.org>, Petr Tesarik <ptesarik@suse.cz>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>

> > If we want to disable unsigned kernel loading at compile time, then we
> > really need to work on decoupling CONFIG_KEXEC and CONFIG_FILE_KEXEC.
> > Introducing another config option is not the way forward, IMHO.
> 
> Yes, let's do it in this way since everyone is fine with it.

I will work on a patch if nobody else have interest or no time on it.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
