Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Tlbyh-000400-QF
 for kexec@lists.infradead.org; Thu, 20 Dec 2012 08:59:45 +0000
Date: Thu, 20 Dec 2012 17:45:25 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH v3 1/7] Initialize and setup eppic
Message-Id: <20121220174525.fa881aafa4c3765172d2ec40@mxc.nes.nec.co.jp>
In-Reply-To: <20121214092604.4854.9670.stgit@aravinda>
References: <20121214092300.4854.30720.stgit@aravinda>
 <20121214092604.4854.9670.stgit@aravinda>
Mime-Version: 1.0
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
To: aravinda@linux.vnet.ibm.com
Cc: ananth@in.ibm.com, mahesh@linux.vnet.ibm.com, kexec@lists.infradead.org, LChouinard@s2sys.com, tachibana@mxm.nes.nec.co.jp, buendgen@de.ibm.com

Hello Aravinda,

Thank you for updating.
I have two comments in this mail.


On Fri, 14 Dec 2012 14:56:04 +0530
Aravinda Prasad <aravinda@linux.vnet.ibm.com> wrote:

> This patch contains routines which initialize eppic and register call
> back function which will be called whenever a new eppic macro is loaded
> using eppic_load() API. The registered call back function executes the
> eppic macro as soon as it is loaded.
> 
> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
> ---
>  Makefile          |    5 +++
>  extension_eppic.c |   84 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  extension_eppic.h |   23 +++++++++++++++
>  3 files changed, 111 insertions(+), 1 deletions(-)
>  create mode 100644 extension_eppic.c
>  create mode 100644 extension_eppic.h
> 
> diff --git a/Makefile b/Makefile
> index e6c4e5d..f123a5f 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -69,7 +69,7 @@ $(OBJ_ARCH): $(SRC_ARCH)
>  	$(CC) $(CFLAGS_ARCH) -c -o ./$@ ./$(@:.o=.c) 
>  
>  makedumpfile: $(SRC) $(OBJ_PART) $(OBJ_ARCH)
> -	$(CC) $(CFLAGS) $(LDFLAGS) $(OBJ_PART) $(OBJ_ARCH) -o $@ $< $(LIBS)
> +	$(CC) $(CFLAGS) $(LDFLAGS) $(OBJ_PART) $(OBJ_ARCH) -rdynamic -o $@ $< $(LIBS)
>  	echo .TH MAKEDUMPFILE 8 \"$(DATE)\" \"makedumpfile v$(VERSION)\" \"Linux System Administrator\'s Manual\" > temp.8
>  	grep -v "^.TH MAKEDUMPFILE 8" makedumpfile.8 >> temp.8
>  	mv temp.8 makedumpfile.8
> @@ -79,6 +79,9 @@ makedumpfile: $(SRC) $(OBJ_PART) $(OBJ_ARCH)
>  	mv temp.5 makedumpfile.conf.5
>  	gzip -c ./makedumpfile.conf.5 > ./makedumpfile.conf.5.gz
>  
> +eppic_makedumpfile.so: extension_eppic.c
> +	$(CC) $(CFLAGS) -nostartfiles -shared -rdynamic -o $@ extension_eppic.c -fPIC -leppic
> +

First, I prepared eppic_makedumpfile.so with the code above, but I failed
with the message below:

  $ makedumpfile -cd31 -x vmlinux --eppic eppic_macro/mod.c vmcore dumpfile.cd31
  process_eppic_file: dlopen failed: /usr/lib64/eppic_makedumpfile.so: undefined symbol: setupterm
  
  makedumpfile Failed.
  $

so I think '-lncurses' should be specified as gcc option, or did I mistake ?


[...]
> +/* Initialize eppic */
> +int
> +_init()
> +{
> +	if (eppic_open() >= 0) {
> +
> +		/* Register call back functions */
> +		eppic_apiset(NULL, 3, sizeof(long), 0);
> +
> +		/* set the new function callback */
> +		eppic_setcallback(reg_callback);
> +
> +		return 0;
> +	}
> +	return 1;
> +}

Second, your code introduce _init() as constructor for dlopen().
I'm not sure about dlopen(), but I found the description which recommend
not to use _init() in man page:

   The obsolete symbols _init() and _fini()
       The linker recognizes special symbols _init and _fini.  If a dynamic library exports a routine named _init(), then that  code  is  executed
       after  the  loading,  before  dlopen()  returns.   If the dynamic library exports a routine named _fini(), then that routine is called just
       before the library is unloaded.  In case you need to avoid linking against the system startup files, this can be done by using  the  gcc(1)
       -nostartfiles command-line option.

       Using these routines, or the gcc -nostartfiles or -nostdlib options, is not recommended.  Their use may result in undesired behavior, since
       the constructor/destructor routines will not be executed (unless special measures are taken).

       Instead, libraries should export routines using the __attribute__((constructor)) and __attribute__((destructor)) function attributes.   See
       the  gcc  info pages for information on these.  Constructor routines are executed before dlopen() returns, and destructor routines are exe-
       cuted before dlclose() returns.

So, is it OK to continue to use _init() ?

BTW, would you send the patch to add the description of this feature
to README, man page and help message ?


Thanks
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
