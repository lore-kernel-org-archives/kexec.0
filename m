Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out03.mta.xmission.com ([166.70.13.233])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lS1Sw-00AahZ-Qz
 for kexec@lists.infradead.org; Thu, 01 Apr 2021 17:50:48 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <CAK5_k=Lao5dYtAWrBMXViM0iEdT0QOj-fPiEsuvkfTogfF=6dA@mail.gmail.com>
 <20210331024745.GB29970@MiWiFi-R3L-srv>
 <CAK5_k=LeBQnmr7HfBZT9HismdfN65oJvrNU8KH1QgP=uYZaezg@mail.gmail.com>
 <20210331034851.GH13786@MiWiFi-R3L-srv>
 <20210331080324.GC29970@MiWiFi-R3L-srv> <YGQujxhxgOvtwb7n@kroah.com>
 <m1pmzfquyr.fsf@fess.ebiederm.org>
 <CAO7dBbWPcjOTcugLkpV9S9uOEhetCg=MiW=xDbAX4EAotBMOHg@mail.gmail.com>
Date: Thu, 01 Apr 2021 12:50:19 -0500
In-Reply-To: <CAO7dBbWPcjOTcugLkpV9S9uOEhetCg=MiW=xDbAX4EAotBMOHg@mail.gmail.com>
 (Liu Tao's message of "Thu, 1 Apr 2021 15:11:56 +0800")
Message-ID: <m1mtuhq4h0.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Subject: Re: kexec does not work for kernel version with patch level >= 256
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
To: Liu Tao <ltao@redhat.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Baoquan He <bhe@redhat.com>, Patrick Sung <patricksung@gmail.com>, sashal@kernel.org, kexec@lists.infradead.org, RuiRui Yang <dyoung@redhat.com>, horms@verge.net.au

Liu Tao <ltao@redhat.com> writes:

> Hello Eric,
>
> I'd like to have a try on this issue.
> Since I'm not very familiar with the related code, maybe I need to spend a
> little more time on it.

Please give it a shot.

Getting rid of explicit kernel version checks would be wonderful and
prevent future problems as well.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
