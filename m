Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UgrL4-0007iD-2Z
 for kexec@lists.infradead.org; Mon, 27 May 2013 06:55:27 +0000
Message-ID: <51A3027B.9090708@cn.fujitsu.com>
Date: Mon, 27 May 2013 14:51:39 +0800
From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: Who uses kexec preserve context logic
References: <20121022185514.GF3401@redhat.com>
In-Reply-To: <20121022185514.GF3401@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Kexec Mailing List <kexec@lists.infradead.org>, linux kernel mailing list <linux-kernel@vger.kernel.org>, Huang Ying <ying.huang@intel.com>

On 10/23/2012 02:55 AM, Vivek Goyal wrote:
> Hi,
> 
> I am just curious to know if somebody uses kexec preserve context path. I 
> have never used it personally and I don't know anybody who makes use of it.
> 
> Is it an unused code and should it be ripped out?
> 

Hi Vivek,

Related commit is:

3ab83521378268044a448113c6aa9a9e245f4d2f kexec jump

From the commit, we can see its purpose is:

"The features of this patch can be used as a general method to call program in
physical mode (paging turning off).  This can be used to call BIOS code under
Linux."

Maybe someone from Intel still uses this...

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
